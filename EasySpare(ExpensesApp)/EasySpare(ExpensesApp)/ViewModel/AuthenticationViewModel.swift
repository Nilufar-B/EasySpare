//
//  MainViewModel.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import SwiftUI

@MainActor
final class AuthenticationViewModel: ObservableObject {
    static var shared: AuthenticationViewModel = AuthenticationViewModel()

    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    @Published var txtPasswordConfirm = ""
    
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false

    
    func signUp() async throws -> AuthDataResultModel {
            guard !txtEmail.isEmpty, !txtPassword.isEmpty else {
                showAlert(message: "No email or password found")
                throw URLError(.badURL)
            }
           // Create a new user using AuthenticationManager
            do {
                let authData = try await AuthenticationManager.shared.createUser(email: txtEmail, password: txtPassword)
                // Ensure authData.uuid is not empty or nil
                let userProfile = UserProfile(userEmail: authData.uuid, plannedExpenses: 0) // Create and save user profile in database
                DBConnections.shared.saveUserProfile(userProfile: userProfile)
                // Create a collection for user's expenses
                DBConnections.shared.createUserExpensesCollection(userId: authData.uuid)
                resetFields()
                return authData
            } catch {
                showAlert(message: "User already exists or another error occurred")
                throw error
            }
        }


    func signIn() async throws -> AuthDataResultModel {
           guard !txtEmail.isEmpty, !txtPassword.isEmpty else {
               showAlert(message: "No email or password found")
               throw URLError(.badURL)
           }
           // Sign in the user using AuthenticationManager
           do {
               let authData = try await AuthenticationManager.shared.signInUser(email: txtEmail, password: txtPassword)
               resetFields()
               return authData
           } catch {
               showAlert(message: "User does not exist or incorrect password")
               throw error
           }
       }

       func signOut() throws {
           do {
               try AuthenticationManager.shared.signOut()
           } catch {
               showAlert(message: "Error signing out")
               throw error
           }
       }

       func resetPassword() async throws {
           // Get the currently authenticated user
           do {
               let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
               
               // Ensure the user's email is available
               guard let email = authUser.email else {
                   showAlert(message: "Email not found for authenticated user")
                   throw URLError(.fileDoesNotExist)
               }
               // Send password reset email
               try await AuthenticationManager.shared.resetPassword(email: email)
               showAlert(message: "Password reset email sent")
           } catch {
               showAlert(message: "Error resetting password")
               throw error
           }
       }
       
       // Method to reset all input fields
       func resetFields() {
           txtEmail = ""
           txtPassword = ""
           txtPasswordConfirm = ""
           isShowPassword = false
       }
    // Method to show alert with a specific message
      func showAlert(message: String) {
          alertMessage = message
          showAlert = true
      }

}

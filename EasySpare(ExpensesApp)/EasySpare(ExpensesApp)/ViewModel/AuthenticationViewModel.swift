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

    func signUp() async throws -> AuthDataResultModel {
        guard !txtEmail.isEmpty, !txtPassword.isEmpty else {
            print("No email or password found") // Replace with alert
            throw URLError(.badURL)
        }
       // Create a new user using AuthenticationManager
        let authData = try await AuthenticationManager.shared.createUser(email: txtEmail, password: txtPassword)
        // Ensure authData.uuid is not empty or nil
        let userProfile = UserProfile(userEmail: authData.uuid, plannedExpenses: 0) // Create and save user profile in database
        DBConnections.shared.saveUserProfile(userProfile: userProfile)
        // Create a collection for user's expenses
        DBConnections.shared.createUserExpensesCollection(userId: authData.uuid)
        resetFields()
        return authData
    }

    func signIn() async throws -> AuthDataResultModel {
        guard !txtEmail.isEmpty, !txtPassword.isEmpty else {
            print("No email or password found") // Replace with alert
            throw URLError(.badURL)
        }
        // Sign in the user using AuthenticationManager
        let authData = try await AuthenticationManager.shared.signInUser(email: txtEmail, password: txtPassword)
              resetFields()
              return authData
    }

    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }

    func resetPassword() async throws {
        // Get the currently authenticated user
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()

        // Ensure the user's email is available
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)  // Создание пользовательской ошибки
        }
        // Send password reset email
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    // Method to reset all input fields
    func resetFields() {
           txtEmail = ""
           txtPassword = ""
           txtPasswordConfirm = ""
           isShowPassword = false
       }

}

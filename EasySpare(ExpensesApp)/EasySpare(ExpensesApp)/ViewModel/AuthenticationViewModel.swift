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
            print("No email or password found") // Замена на алерт
            throw URLError(.badURL)
        }
        
        let authData = try await AuthenticationManager.shared.createUser(email: txtEmail, password: txtPassword)
        let userProfile = UserProfile(userName: authData.uuid, plannedExpenses: 0)
        DBConnections.shared.saveUserProfile(userProfile: userProfile)
        DBConnections.shared.createUserExpensesCollection(userId: authData.uuid)
        resetFields()
        return authData
    }

    func signIn() async throws -> AuthDataResultModel {
        guard !txtEmail.isEmpty, !txtPassword.isEmpty else {
            print("No email or password found")
            throw URLError(.badURL)
        }
        let authData = try await AuthenticationManager.shared.signInUser(email: txtEmail, password: txtPassword)
              resetFields()
              return authData
    }

    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }

    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()

        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)  // Создание пользовательской ошибки
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func resetFields() {
           txtEmail = ""
           txtPassword = ""
           txtPasswordConfirm = ""
           isShowPassword = false
       }

}

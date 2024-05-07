//
//  AuthenticationManager.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-06.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uuid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User){
        self.uuid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}
class AuthenticationState: ObservableObject {
    @Published var isAuthenticated = false
}

@MainActor
final class AuthenticationManager {
    static let shared = AuthenticationManager() //синглтон дизайн паттерн, не самый лучгий способ но приложение маленькое
    
    private init() {}
    

    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }


    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        return AuthDataResultModel(user: authDataResult.user)
    }


    func signOut() throws {
        try Auth.auth().signOut()
    }
}
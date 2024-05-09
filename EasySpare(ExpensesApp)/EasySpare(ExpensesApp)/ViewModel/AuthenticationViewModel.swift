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

     
     func signUp() async throws{
         guard !txtEmail.isEmpty,  !txtPassword.isEmpty else {
             print("No email or password found") //заменить потом на alert
             return
         }
         
         try await  AuthenticationManager.shared.createUser(email: txtEmail,password: txtPassword)
         
     }
     
     func signIn() async throws {
         guard !txtEmail.isEmpty, !txtPassword.isEmpty else{
             print("No email or password found")
             return
         }
         try await AuthenticationManager.shared.signInUser(email: txtEmail, password: txtPassword)
     }
     
     func signOut() throws {
         try AuthenticationManager.shared.signOut()
     }
     
     func resetPassword() async throws {
         let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
         
         guard let email = authUser.email else {
             throw URLError(.fileDoesNotExist)  //create custom error instead
         }
       try await  AuthenticationManager.shared.resetPassword(email: email)
     }
     
     func updatePassword() {
         
     }
     
     func updateEmail() {
         
     }
}



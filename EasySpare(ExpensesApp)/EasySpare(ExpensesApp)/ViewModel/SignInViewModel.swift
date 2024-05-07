//
//  MainViewModel.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import SwiftUI

@MainActor
 final class SignInViewModel: ObservableObject {
    static var shared: SignInViewModel = SignInViewModel()
  
    
     
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    @Published var txtPasswordConfirm = ""

     
     func logIn() {
         guard !txtEmail.isEmpty,  !txtPassword.isEmpty else {
             print("No email or password found") //заменить потом на alert
             return
         }
         
         Task{
             do{
                 let returnedUserData = try await  AuthenticationManager.shared.createUser(email: txtEmail,password: txtPassword)
                 print("Success")
                 print(returnedUserData)
             }catch{
                 print("Error:\(error)")
             }
         }
     }
}




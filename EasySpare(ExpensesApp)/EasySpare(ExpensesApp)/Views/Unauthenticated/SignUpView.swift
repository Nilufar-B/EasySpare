//
//  SignUpView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-05.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var loginVM = AuthenticationViewModel.shared
    @State private var isRegistrationSuccess = false
    @Binding var showSignInView: Bool
    
    var onSignUpSuccess: (AuthDataResultModel) -> Void

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    
                    VStack {
                        Image(systemName:"person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .foregroundColor(.black)
                            .padding(.bottom, 40)
                        
                        Text("Create your account")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 40)
                        
                        TextFieldLine(title: "Email", placeholder: "Enter your email address", txt: $loginVM.txtEmail, keyboardType: .emailAddress)
                            .padding(.bottom, 8)
                        
                        TextSecureLine(title: "Password", placeholder: "Enter your password", txt: $loginVM.txtPassword, isShowPassword: $loginVM.isShowPassword)
                            .padding(.bottom, 8)
                        
                        TextSecureLine(title: "Confirm Password", placeholder: "Confirm your password", txt: $loginVM.txtPasswordConfirm, isShowPassword: $loginVM.isShowPassword)
                            .padding(.bottom, 20)
                        
                        CustomButton(title: "Register") {
                            Task {
                                do {
                                    try await loginVM.signUp()
                                    if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
                                    loginVM.resetFields()
                                    showSignInView = false
                                   onSignUpSuccess(authUser)
                                    }
                                } catch {
                                    print(error)
                                        }
                                }
                        }
                        .padding(.bottom, 8)
                        
                        HStack {
                            Text("Already have an account?")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                            
                            NavigationLink(destination: LoginView(showSignInView: $showSignInView, onLoginSuccess: { email in
                                onSignUpSuccess(email)
                                mode.wrappedValue.dismiss()
                            })) {
                                Text("Log In")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundColor(.secondary)
                                    .onTapGesture {
                                        mode.wrappedValue.dismiss()
                                    }
                            }
                            .navigationBarBackButtonHidden(true)
                        }
                        Spacer()
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 5)
                .padding(.top, 30)
                .background(Color.white)
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignInView: .constant(true), onSignUpSuccess: { _ in })
    }
}

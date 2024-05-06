//
//  SignUpView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-05.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment (\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var loginVM = MainViewModel.shared  // Используйте ViewModel, подходящий для регистрации, если нужно

    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                
                Image("")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                
                    Image(systemName:"person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundColor(.black)
                        .padding(.bottom, 40)
                    
                    Text("Sign Up")
                        .font(.system(size: 26))
                        .foregroundColor(.primary)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    Text("Create your account")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 40)
                    
                    TextFieldLine(title: "Email", placeholder: "Enter your email address", txt: $loginVM.txtEmail, keyboardType: .emailAddress)
                        .padding(.bottom, 8)
                    
                    TextSecureLine(title: "Password", placeholder: "Enter your password", txt: $loginVM.txtPassword, isShowPassword: $loginVM.isShowPassword)
                        .padding(.bottom, 8)

                    TextSecureLine(title: "Confirm Password", placeholder: "Confirm your password", txt: $loginVM.txtPasswordConfirm, isShowPassword: $loginVM.isShowPassword)
                        .padding(.bottom, 20)

                    CustomButton(title: "Register")
                        .padding(.bottom, 8)
                    
                    HStack{
                        Text("Already have an account?")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                        
                        Text("Log In")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                mode.wrappedValue.dismiss()
                            }
                    }
                    
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)

                VStack{
                    HStack{
                        Button(action: {
                            mode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        })
                        .padding()
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width, alignment: .leading)
            }
            .padding(.horizontal, 5)
            .padding(.top, 30)
            .background(Color.white)
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SignUpView()
}

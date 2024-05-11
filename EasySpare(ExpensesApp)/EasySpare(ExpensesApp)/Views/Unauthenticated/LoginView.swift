//
//  LoginView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import SwiftUI


struct LoginView: View {
    
    @Environment (\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var loginVM = AuthenticationViewModel.shared
    @Binding var showSignInView: Bool


    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    
                    Image("")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        
                        Image(systemName:"books.vertical.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .foregroundColor(.black)
                            .padding(.bottom, 40)
                        
                        Text("Log In")
                            .font(.system(size: 26))
                            .foregroundColor(.primary)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 4)
                        
                        Text("Enter your credentials")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 40)
                        
                        TextFieldLine(title: "Email", placeholder: "Enter your email adress", txt: $loginVM.txtEmail,keyboardType: .emailAddress)
                            .padding(.bottom, 8)
                        
                        TextSecureLine(title: "Password", placeholder: "Enter your password", txt: $loginVM.txtPassword, isShowPassword: $loginVM.isShowPassword)
                            .padding(.bottom, 8)
                        
                        Button(action: {
                            Task{
                                do{
                                    try await loginVM.resetPassword()
                                    print("Password reset")
                                }catch{
                                    print(error)
                                }
                            }
                        }, label: {
                            Text("Forgot Password?")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                            
                        })
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        .padding(.bottom, 40)
                        
                        CustomButton(title: "Log In") {
                            Task{
                                do{
                                    try await loginVM.signIn()
                                    showSignInView = false
                                    return
                                }catch{
                                    print(error)
                                }
                            }
                       
                        }
                        .padding(.bottom, 8)
                      
                            HStack{
                                Text("Don't have an account?")
                                    .font(.system(size: 16))
                                    .foregroundColor(.secondary)
                                
                                NavigationLink(destination: SignUpView(showSignInView: $showSignInView)) {
                                    
                                Text("Sign Up")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundColor(.secondary)
                            }
                                .navigationBarBackButtonHidden(true)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                    .navigationTitle("Log In")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                    .ignoresSafeArea()
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
                
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack{
       LoginView(showSignInView: .constant(false))
    }
}

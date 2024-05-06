//
//  LoginView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import Foundation
import SwiftUI
import CountryPicker

struct SignInView: View{
    
    @State var txtMobile: String = ""
    @State var isPicker: Bool = false
    @State var countryObj: Country?
    
    var body: some View{
        GeometryReader{ geometry in 
            ZStack{
                
                Image("")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                VStack{
                    Image("")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    Spacer()
                }
                VStack{
                    
                    Text("Make sure ...")
                        .font(.system(size: 26))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 25)
                    
                    HStack{
                        Button(action: {
                            isPicker = true
                        }, label: {
                            //    Image("")
                            
                            if let countryObj = countryObj {
                                
                                Text("\(countryObj.isoCode.getFlag())")
                                    .font(.system(size: 20))
                                
                                
                                
                                Text("+\(countryObj.phoneCode)")
                                    .font(.system(size: 18))
                                    .foregroundColor(.black.opacity(0.8))
                            }
                            
                        })
                        
                        TextField("Enter Mobile", text: $txtMobile)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .center)
                        
                    }
                    Divider()
                        .padding(.bottom, 25)
                    
                    Text("Or sign in with email")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                        .padding(.bottom, 25)
                    
                    Button(action: {
                        
                    }, label: {
                        Image("icon_google")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("Continue with Google")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    })
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .background(Color.mint)
                    .cornerRadius(20)
                    .padding(.bottom, 8)
                    
                    Button(action: {
                        
                    }, label: {
                        Image("icon_facebook")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("Continue with Facebook")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    })
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                    .background(Color.mint)
                    .cornerRadius(20)
                    
                }
                .padding(.horizontal, 20)
                .frame(width: 400, alignment: .leading)
                .padding(.top)
                
                
                
                
            }
            .onAppear{
                self.countryObj = Country(phoneCode: "46", isoCode: "SE")
            }
            .sheet(isPresented: $isPicker, content: {
                CountryPicker(country: $countryObj)
            })
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            
        }
    }
}



#Preview {
    SignInView()
}

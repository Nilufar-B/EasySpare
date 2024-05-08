//
//  WelcomeView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {

            GeometryReader { geometry in
                                          
                    ZStack {
                        Image("")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            
                            Spacer()
                            
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .padding(.bottom, 8)
                            
                            Text("Welcome to EasySpair")
                                .font(.system(size: 46))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text("Take your expenses under control")
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 20)
                            
                            NavigationLink {
                                LoginView(showSignInView: $showSignInView)
                            } label: {
                          
                                Text("Get Started")
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                                    .background(Color.mint)
                                    .cornerRadius(20)
                                
                                
                            }
                            
                            Spacer()
                                .frame(height: 80)
                            
                            
                                .padding(.horizontal, 20)
                        }
                        .padding()
                        .navigationTitle("")
                    }
              
                }
            }
            
           
        }
    



#Preview {
    NavigationStack{
        WelcomeView(showSignInView: .constant(false))
    }

   
}

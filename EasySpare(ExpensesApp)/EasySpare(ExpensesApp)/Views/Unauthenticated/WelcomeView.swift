//
//  WelcomeView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("welcomeView")
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
                        SignInView()
                    } label: {
                        CustomButton(title: "Get Started"){
                            
                        }
                    }
                    
                    
                    
                    Spacer()
                        .frame(height: 80)
                    
                    
                        .padding(.horizontal, 20)
                }
                .padding()
            }
        }

                .ignoresSafeArea()
                .navigationTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
        }

    

#Preview {
    NavigationView{
        WelcomeView()
    }
   
}

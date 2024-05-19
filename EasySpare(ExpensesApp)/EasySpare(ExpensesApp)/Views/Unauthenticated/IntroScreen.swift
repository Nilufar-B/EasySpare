//
//  IntroScreen.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-09.
//

import SwiftUI

struct IntroScreen: View {
    
    @AppStorage("hasShownIntro") private var hasShownIntro: Bool = true
    var onContinue: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Welcome to Easy Spare")
                .font(Font.custom("JosefinSans-Bold", size: 30))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
               // .padding(.horizontal, 30)
            
            Text("Take control of your expenses effortlessly.")
                .font(Font.custom("JosefinSans-Semibold", size: 20))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            
            Divider()
        
            VStack(alignment: .leading, spacing: 30) {
                FunctionView(symbol: "eurosign.circle", title: "Manage Transactions", description: "Keep track of all your financial transactions.")
                FunctionView(symbol: "chart.bar.xaxis", title: "Visual Charts", description: "Visualize your data with detailed charts.")
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            CustomButton(title: "Continue") {
                hasShownIntro = false
                onContinue()
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        IntroScreen(onContinue: {})
    }
}

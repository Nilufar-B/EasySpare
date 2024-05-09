//
//  IntroScreen.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-09.
//

import SwiftUI

struct IntroScreen: View {
    
    @AppStorage("hasShownIntro") private var hasShownIntro: Bool = true
    var body: some View {
        
        VStack(spacing: 15){
                Text("Discover What’s Possible with\nYour Finances")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)
            
            VStack(alignment: .leading, spacing: 25, content: {
                PointView(symbol: "eurosign.arrow.circlepath", title: "Transaktions", subTitle: "Seamlessly manage all your financial transactions in one place.")
                
                PointView(symbol: "chart.bar.xaxis.ascending.badge.clock", title: "Visual Charts", subTitle: "Transform your data with vibrant, informative charts and graphs.")
                
                PointView(symbol: "magnifyingglass", title: "Advance Filters", subTitle: "Quickly navigate through your financial records with powerful filtering options.")
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            
            Spacer(minLength: 10)
            
            //when tapped the app storage will be set to false, and thus it won't appear again when the app opens
            CustomButton(title: "Continue"){
                hasShownIntro = false
            }
            }
        .padding(15)
        }
    }

@ViewBuilder
func PointView(symbol: String, title: String, subTitle: String) -> some View {
    HStack(spacing: 20){
        Image(systemName: symbol)
            .font(.largeTitle)
            .foregroundStyle(appTint.gradient)
            .frame(width: 45)
        
        VStack(alignment: .leading, spacing: 6, content: {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(subTitle)
                .foregroundColor(.gray)
        })
    }
}


#Preview {
    IntroScreen()
}

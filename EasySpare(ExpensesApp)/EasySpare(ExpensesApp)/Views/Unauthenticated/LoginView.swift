//
//  LoginView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import Foundation
import SwiftUI

struct LoginView: View{
    var body: some View{
        
        ZStack{
            VStack{
                
                Text("Make sure ...")
                    .font(.system(size: 26))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 25)
                
                HStack{
                    Button(action: {
                        
                    }, label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    })
                }
            }
            .padding(.horizontal, 20)
          
        }
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}



#Preview {
    LoginView()
}

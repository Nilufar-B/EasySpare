//
//  CustomButton.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import SwiftUI

struct CustomButton: View {
    
    @State var title: String = "Title"
    var didTap: (()->())?
    var body: some View {
        Button(action: {
            didTap?()
        }, label: {
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        })
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(Color.mint)
        .cornerRadius(20)
        
    }
}

#Preview {
    CustomButton()
        .padding(20)
}

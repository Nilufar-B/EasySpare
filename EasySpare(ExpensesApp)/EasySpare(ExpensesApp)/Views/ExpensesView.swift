//
//  ExpensesView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-07.
//

import SwiftUI

struct ExpensesView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack{
            Text("ExpensesView")
        }
    }
}

#Preview {
    ExpensesView(showSignInView: .constant(false))
}

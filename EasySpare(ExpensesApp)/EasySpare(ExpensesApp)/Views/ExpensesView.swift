//
//  ExpensesView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-07.
//

import SwiftUI

struct ExpensesView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                ProfileView(showSignInView: $showSignInView)
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack{
                WelcomeView()
            }
        })
    }
}

#Preview {
    ExpensesView()
}

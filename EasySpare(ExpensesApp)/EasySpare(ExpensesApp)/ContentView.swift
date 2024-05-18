//
//  ContentView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import SwiftUI


struct ContentView: View {
    
        @AppStorage("hasShownIntro") private var hasShownIntro: Bool = false
         @State private var showSignInView: Bool = true
         @State private var activeTab: Tab = .expenses
    @State private var userId: String = ""
         
         var body: some View {
             ZStack{
                 if !hasShownIntro {
                     IntroScreen(onContinue: {
                         hasShownIntro = true
                         checkLoginStatus()
                     })
                 }else if showSignInView {
                     LoginView(showSignInView: $showSignInView,
                               onLoginSuccess: { authUserId in
                         userId = authUserId
                         checkLoginStatus()
                     })
                 }else {
                //  SettingsView.(showSignInView: $showSignInView)
                     TabView(selection: $activeTab) {
                         ExpensesView(userId: userId)
                         .tabItem { Tab.expenses.tabContent }.tag(Tab.expenses)
                    // SearchView()
                            // .tabItem { Tab.search.tabContent }.tag(Tab.search)
                     GraphView(userId: userId)
                             .tabItem { Tab.charts.tabContent }.tag(Tab.charts)
                     SettingsView(showSignInView: $showSignInView)
                             .tabItem { Tab.settings.tabContent }.tag(Tab.settings)
                     }
                     .tint(appTint)
                 }
             }

         }
    @MainActor
    private func checkLoginStatus() {
           if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
               showSignInView = false
               userId = authUser.uuid
           } else {
               showSignInView = true
           }
       }
    }

    
#Preview {
    ContentView()
}


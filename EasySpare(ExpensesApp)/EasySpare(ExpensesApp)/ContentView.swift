//
//  ContentView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel.shared
    @AppStorage("hasShownIntro") private var hasShownIntro: Bool = false
    @State private var showSignInView: Bool = true
    @State private var activeTab: Tab = .expenses
    @State private var userId: String = ""
    @State private var userEmail: String = ""

    var body: some View {
        ZStack {
            if !hasShownIntro {
                IntroScreen(onContinue: {
                    hasShownIntro = true
                    checkLoginStatus()
                })
            } else if showSignInView {
                LoginView(showSignInView: $showSignInView, onLoginSuccess: { authData in
                    userId = authData.uuid
                    userEmail = authData.email ?? ""
                    checkLoginStatus()
                    activeTab = .expenses
                })
            } else {
                TabView(selection: $activeTab) {
                    ExpensesView(userId: userId, userEmail: userEmail)
                        .tabItem { Tab.expenses.tabContent }.tag(Tab.expenses)
                    GraphView(userId: userId)
                        .tabItem { Tab.charts.tabContent }.tag(Tab.charts)
                    SettingsView(showSignInView: $showSignInView, userEmail: userEmail)
                        .tabItem { Tab.settings.tabContent }.tag(Tab.settings)
                }
                .tint(appTint)
                .onAppear {
                    checkLoginStatus()
               }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
                 Alert(title: Text("Alert"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
             }
    }

    @MainActor
        private func checkLoginStatus() {
            if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
                showSignInView = false
                userId = authUser.uuid
                userEmail = authUser.email ?? ""
            } else {
                showSignInView = true
                userId = ""
                userEmail = ""
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

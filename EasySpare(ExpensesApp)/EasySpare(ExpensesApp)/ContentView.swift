//
//  ContentView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-03.
//

import SwiftUI


struct ContentView: View {
    
  //  @State private var showSignInView: Bool = false
    
   // var body: some View {
   /*     VStack {
            
            
            ZStack{
                NavigationStack{
                   // ExpensesView(showSignInView: $showSignInView)
                    ProfileView(showSignInView: $showSignInView)
                }
            }
            .onAppear{
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                self.showSignInView = authUser == nil
            }
            .padding()
            .fullScreenCover(isPresented: $showSignInView, content: {
                NavigationStack{
                    WelcomeView(showSignInView: $showSignInView)
                }
            })
        }*/
        @AppStorage("hasShownIntro") private var hasShownIntro: Bool = false
         @State private var showSignInView: Bool = true
         @State private var activeTab: Tab = .expenses
         
         var body: some View {
             ZStack{
                 if !hasShownIntro {
                     IntroScreen(onContinue: {
                         hasShownIntro = true
                         checkLoginStatus()
                     })
                 }else if showSignInView {
                     LoginView(showSignInView: $showSignInView)
                 }else {
                //  SettingsView.(showSignInView: $showSignInView)
                     TabView(selection: $activeTab) {
                         ExpensesView()
                         .tabItem { Tab.expenses.tabContent }.tag(Tab.expenses)
                     SearchView()
                             .tabItem { Tab.search.tabContent }.tag(Tab.search)
                     GraphView()
                             .tabItem { Tab.charts.tabContent }.tag(Tab.charts)
                     SettingsView()
                             .tabItem { Tab.settings.tabContent }.tag(Tab.settings)
                     }
                     .tint(appTint)
                 }
             }
             /*
         ZStack{
         NavigationStack{
         //  ExpensesView(showSignInView: $showSignInView)
         TabView(selection: $activeTab) {
         Text("Recents").tabItem { Tab.recents.tabContent }.tag(Tab.recents)
         Text("Search").tabItem { Tab.search.tabContent }.tag(Tab.search)
         Text("Chart").tabItem { Tab.charts.tabContent }.tag(Tab.charts)
         Text("Settings").tabItem { Tab.settings.tabContent }.tag(Tab.settings)
         }
         .tint(appTint)
         }
         }
         .onAppear{
         let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
         self.showSignInView = authUser == nil
         }
         .sheet(isPresented: $hasShownIntro, content: {
             IntroScreen()
                 .interactiveDismissDisabled()
         })*/
         }
    @MainActor
    private func checkLoginStatus() {
           if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
               showSignInView = false
           } else {
               showSignInView = true
           }
       }
    }

    
    /*
    @AppStorage("hasShownIntro") private var hasShownIntro: Bool = true
    @State private var activeTab: Tab = .recents
    
    var body: some View {
        TabView(selection: $activeTab) {
            Text("Recents").tabItem { Tab.recents.tabContent }.tag(Tab.recents)
            Text("Search").tabItem { Tab.search.tabContent }.tag(Tab.search)
            Text("Chart").tabItem { Tab.charts.tabContent }.tag(Tab.charts)
            Text("Settings").tabItem { Tab.settings.tabContent }.tag(Tab.settings)
          }
        .sheet(isPresented: $hasShownIntro, content: {
            IntroScreen()
                .interactiveDismissDisabled()
        })
       }
     */
    
#Preview {
    ContentView()
}


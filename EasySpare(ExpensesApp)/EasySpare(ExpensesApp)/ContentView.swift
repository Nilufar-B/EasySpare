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
        
         @State private var showSignInView: Bool = false
         @State private var activeTab: Tab = .recents
         
         var body: some View {
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
         .fullScreenCover(isPresented: $showSignInView, content: {
         NavigationStack{
         WelcomeView(showSignInView: $showSignInView)
         }
         })
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


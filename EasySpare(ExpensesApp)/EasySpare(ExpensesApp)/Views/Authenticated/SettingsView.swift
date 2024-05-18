//
//  SettingsView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-10.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("userName") private var userName: String = ""
    @StateObject private var loginVM = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    @State private var plannedExpenses: Double = 0
    
    var body: some View {
        NavigationStack{
            ZStack{
                List {
                    Section("User Name") {
                        TextField("iName", text: $userName)
                            .autocorrectionDisabled()
                    }
                }
                .navigationTitle("Settings")
                
                VStack{
                    CustomButton(title: "Save", didTap: {
                        let userProfile = UserProfile(userName: userName, plannedExpenses: plannedExpenses)
                    DBConnections.shared.saveUserProfile(userProfile: userProfile)
                    })
                    
                    Button(action: {
                        Task{
                            do{
                                try loginVM.signOut()
                                showSignInView = true
                            }catch{
                                print(error)
                            }
                        }
                    }) {
                        Text("Log Out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
      
            }
        }
        .padding(10)
    }
}

#Preview {
    SettingsView(showSignInView: .constant(false))
}

//
//  SettingsView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-10.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSignInView: Bool
    var userEmail: String

    var body: some View {
    
        NavigationStack{
                    ZStack{
                        List {
                            Section("E-mail") {
                                Text("\(userEmail)")
                                    .autocorrectionDisabled()
                            }
                        }
                        .navigationTitle("Settings")
                        
                        VStack{
                            CustomButton(title: "Log Out", didTap: {
                                Task {
                                    try? AuthenticationManager.shared.signOut()
                                    showSignInView = true
                                }
                            })
                
                        }
                                  
                }
            }
        .padding(10)
    }
}

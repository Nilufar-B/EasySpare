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
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    List {
                        Section("E-mail") {
                            Text("\(userEmail)")
                                .autocorrectionDisabled()
                        }
                    }
                    .navigationTitle("Settings")
                    
                    VStack {
                        Spacer()
                        CustomButton(title: "Log Out", didTap: {
                            Task {
                                try? AuthenticationManager.shared.signOut()
                                showSignInView = true
                            }
                        })
                        .frame(maxWidth: geometry.size.width * 0.9) // Adjust button width based on available space
                        .padding(.bottom, 20)
                    }
                }
            }
            .padding(10)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSignInView: .constant(false), userEmail: "example@example.com")
    }
}

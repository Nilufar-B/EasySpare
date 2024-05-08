//
//  ProfileView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-06.
//
import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var loginVM = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)

                    VStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.blue)
                            .padding(.bottom, 20)

                        Text("")
                            .font(.title)
                            .padding(.bottom, 10)

                        Text("")
                            .foregroundColor(.gray)
                            .padding(.bottom, 40)

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
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 30)
                    .navigationBarTitle("Profile", displayMode: .inline)
                    .navigationBarItems(trailing:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                        }
                    )
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(showSignInView: .constant(false))
    }
}


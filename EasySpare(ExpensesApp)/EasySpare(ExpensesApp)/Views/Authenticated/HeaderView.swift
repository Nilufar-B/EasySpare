//
//  SwiftUIView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-10.
//

import SwiftUI

struct HeaderView: View {
    @AppStorage("userName") private var userName: String = ""
    var size: CGSize
    var userId: String
    var onSave: () -> Void

    var body: some View {
            HStack(spacing: 10){
                VStack(alignment: .leading, spacing: 5, content: {
                    Text("Welcome!")
                        .font(.title.bold())
                    
                    if !userName.isEmpty {
                        Text(userName)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                       
                })
                .padding(.bottom, 8)
                .visualEffect { content, geometryProxy in
                    content
                        .scaleEffect(headerScale( size, proxy: geometryProxy), anchor: .topLeading)
                }
                
                Spacer(minLength: 0)
                
                NavigationLink{
                    AddTransactionView(isPresented: .constant(true), userId: userId, onSave: onSave)
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 45, height: 45)
                        .background(appTint.gradient, in: .circle)
                        .contentShape(.circle)
                }
            }
            .padding(.bottom,userName.isEmpty ? 10 : 5)
                .background {
                    VStack(spacing: 0){
                        Rectangle()
                            .fill(.ultraThinMaterial)
                        
                        Divider()
                    }
                    .visualEffect { content, geometryProxy in
                        content
                            .opacity(headerOpacity(geometryProxy))
                    }
                        .padding(.horizontal, -15)
                        .padding(.top, -(safeArea.top + 15))
                }
            }
        }


//  HeaderView.swift
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
    @State private var isAddTransactionPresented = false

    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
               /*
                if !userName.isEmpty {
                    Text(userName)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }*/
            }
            .padding(.bottom, 8)
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            
            Spacer(minLength: 0)
            
            Button(action: {
                isAddTransactionPresented = true
            }) {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
            }
            .sheet(isPresented: $isAddTransactionPresented) {
                AddTransactionView(isPresented: $isAddTransactionPresented, userId: userId, onSave: onSave)
            }
        }
        .padding(.bottom, userName.isEmpty ? 10 : 5)
        .background {
            VStack(spacing: 0) {
                Rectangle().fill(.ultraThinMaterial)
                Divider()
            }
            .visualEffect { content, geometryProxy in
                content.opacity(headerOpacity(geometryProxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }
}

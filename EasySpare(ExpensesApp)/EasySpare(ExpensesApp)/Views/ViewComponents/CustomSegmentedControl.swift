//
//  CustomSegmentedControl.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-13.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var selectedCategory: Category
    var namespace: Namespace.ID

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.self) { category in
                Text(category.rawValue)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(
                        category == selectedCategory ? Capsule().fill(Color.blue.opacity(0.2)) : nil
                    )
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            selectedCategory = category
                        }
                    }
            }
        }
        .background(Capsule().fill(Color.gray.opacity(0.15)))
    }
}

//
//  AddTransactionsView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-14.
//

import SwiftUI
import Firebase


struct AddTransactionView: View {
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: String = ""
    @State private var dateAdded: Date = Date()
    @State private var category: Category = .expense
    @State private var selectedTintColor: TintColor = tints.first!

    var userId: String

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Title", text: $title)
                    TextField("Remarks", text: $remarks)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $dateAdded, displayedComponents: .date)
                    Picker("Category", selection: $category) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    Picker("Color", selection: $selectedTintColor) {
                        ForEach(tints, id: \.id) { tintColor in
                            Text(tintColor.color).tag(tintColor)
                        }
                    }
                }
                CustomButton(title: "Save", didTap: {
                    saveTransaction()
                })
                .padding()
            }
            .navigationTitle("Add Transaction")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
    
    func saveTransaction() {
        // Saving data to Firestore
        let transaction = Transactions(
            title: title,
            remarks: remarks,
            amount: Double(amount) ?? 0,
            dateAdded: dateAdded,
            category: category,
            tintColor: selectedTintColor
        )
        FirestoreManager.shared.saveTransaction(transaction, userId: userId)
        isPresented = false
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(isPresented: .constant(true), userId: "exampleUserId")
    }
}

//
//  EditTransactionView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-21.
//

import SwiftUI

struct EditTransactionView: View {
    @Binding var isPresented: Bool
    @State private var title: String
    @State private var remarks: String
    @State private var amount: String
    @State private var dateAdded: Date
    @State private var category: Category
    @State private var selectedTintColor: TintColor
    
    var userId: String
    var transaction: Transactions
    var onSave: () -> Void

    init(isPresented: Binding<Bool>, userId: String, transaction: Transactions, onSave: @escaping () -> Void) {
        self._isPresented = isPresented
        self.userId = userId
        self.transaction = transaction
        self.onSave = onSave
        self._title = State(initialValue: transaction.title)
        self._remarks = State(initialValue: transaction.remarks)
        self._amount = State(initialValue: String(transaction.amount))
        self._dateAdded = State(initialValue: transaction.dateAdded)
        self._category = State(initialValue: transaction.category)
        self._selectedTintColor = State(initialValue: TintColor(color: transaction.tintColor, value: .red)) // Замените .red на подходящий цвет
    }

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
            .navigationTitle("Edit Transaction")
        }
    }
    
    func saveTransaction() {
        guard let amountValue = Double(amount), !amountValue.isNaN else {
            print("Invalid amount value")
            return
        }
        
        let updatedTransaction = Transactions(
            id: transaction.id, // Используйте существующий идентификатор
            title: title,
            remarks: remarks,
            amount: amountValue,
            dateAdded: dateAdded,
            category: category,
            tintColor: selectedTintColor.color
        )
        
        FirestoreManager.shared.updateTransaction(transaction: updatedTransaction, userId: userId) {
            onSave()
            isPresented = false
        }
    }
}

struct EditTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        EditTransactionView(isPresented: .constant(true), userId: "exampleUserId", transaction: Transactions(title: "Sample", remarks: "Sample Remarks", amount: 100.0, dateAdded: Date(), category: .expense, tintColor: tints.first!.color), onSave: {})
    }
}

//
//  Transactions.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-09.
//

import SwiftUI

struct Transactions: Identifiable {
    let id: UUID = .init()
    
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String // use it to dive a random color to each transaction view
    
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    //Extracting Color value from tintColor String
    
    var color: Color {
        return tints.first (where: {
            $0.color == tintColor
        })?.value ?? appTint
    }
}


//sample transactions for UI

var sampleTransactions: [Transactions] = [
    .init(title: "Magic Keyboard", remarks: "Apple Product", amount: 129, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Magic Keyboard", remarks: "Apple Product", amount: 129, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Magic Keyboard", remarks: "Apple Product", amount: 129, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Magic Keyboard", remarks: "Apple Product", amount: 129, dateAdded: .now, category: .expense, tintColor: tints.randomElement()!),
    .init(title: "Payment", remarks: "Payment Recived!", amount: 129, dateAdded: .now, category: .income, tintColor: tints.randomElement()!),
    
]

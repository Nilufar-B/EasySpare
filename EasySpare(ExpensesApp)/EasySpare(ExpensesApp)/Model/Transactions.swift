//
//  Transactions.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-09.
//

import SwiftUI

struct Transactions: Identifiable {
    let id: String
    
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: Category
    var tintColor: String // use it to dive a random color to each transaction view
    
    init(id: String = UUID().uuidString, title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: String) {
        self.id = id
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category
        self.tintColor = tintColor
    }
    
    //Extracting Color value from tintColor String
    
    var color: Color {
        return tints.first (where: {
            $0.color == tintColor
        })?.value ?? appTint
    }
}



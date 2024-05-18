//
//  Category.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-09.
//

import SwiftUI

enum Category: String, CaseIterable {
    case income = "Income"
    case expense = "Expense"
}

enum ExpenseCategory: String, CaseIterable, Identifiable {
    case entertainment = "Entertainment"
    case food = "Food"
    case bills = "Bills"
    case travel = "Travel"
    case shopping = "Shopping"
    case health = "Health"
    case others = "Others"
    
    var id: String { self.rawValue }
}

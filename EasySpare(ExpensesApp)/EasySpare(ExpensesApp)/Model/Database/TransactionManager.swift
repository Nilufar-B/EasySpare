//
//  AuthenticationManager.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-06.
//

import Foundation
import FirebaseFirestore

class TransactionManager: ObservableObject {
    @Published var transactions: [Transactions] = []

    func fetchTransactions(userId: String, completion: @escaping () -> Void) {
        FirestoreManager.shared.fetchTransactions(userId: userId) { fetchedTransactions in
            DispatchQueue.main.async {
                self.transactions = self.filterAndSortTransactions(fetchedTransactions)
                completion()
            }
        }
    }

    private func filterAndSortTransactions(_ transactions: [Transactions]) -> [Transactions] {
        return transactions
            .filter { !$0.amount.isNaN }
            .sorted { $0.dateAdded > $1.dateAdded } // Sort by date in descending order
    }

    func processTransactions(for interval: CustomTimeInterval, selectedDate: Date) -> [Transactions] {
        let calendar = Calendar.current
        return transactions.filter { transaction in
            switch interval {
            case .day:
                return calendar.isDate(transaction.dateAdded, equalTo: selectedDate, toGranularity: .day)
            case .week:
                guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: selectedDate)),
                      let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
                    return false
                }
                return transaction.dateAdded >= startOfWeek && transaction.dateAdded <= endOfWeek
            case .month:
                return calendar.isDate(transaction.dateAdded, equalTo: selectedDate, toGranularity: .month)
            }
        }
    }
    
    func processMonthlyTransactions(for date: Date) -> [(month: Int, income: Double, expense: Double)] {
        var monthlyTransactions: [Int: (income: Double, expense: Double)] = [:]
        let calendar = Calendar.current
        
        for transaction in transactions {
            let month = calendar.component(.month, from: transaction.dateAdded)
            let year = calendar.component(.year, from: transaction.dateAdded)
            let currentYear = calendar.component(.year, from: date)
            
            if year == currentYear {
                if transaction.category.rawValue == Category.income.rawValue {
                    monthlyTransactions[month, default: (0, 0)].income += transaction.amount
                } else if transaction.category.rawValue == Category.expense.rawValue {
                    monthlyTransactions[month, default: (0, 0)].expense += transaction.amount
                }
            }
        }
        
        return monthlyTransactions.map { (month: $0.key, income: $0.value.income, expense: $0.value.expense) }
    }

    func monthName(from month: Int) -> String {
        let formatter = DateFormatter()
        return formatter.shortMonthSymbols[month - 1]
    }

    func weekdayName(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Mon, Tue, Wed, etc.
        return formatter.string(from: date)
    }

    func calculateIncome() -> Double {
        return transactions
            .filter { $0.category.rawValue == Category.income.rawValue }
            .reduce(0) { $0 + $1.amount }
    }

    func calculateExpense() -> Double {
        return transactions
            .filter { $0.category.rawValue == Category.expense.rawValue }
            .reduce(0) { $0 + $1.amount }
    }

    func deleteTransaction(userId: String, transaction: Transactions) {
        FirestoreManager.shared.deleteTransaction(userId: userId, transactionId: transaction.id) { error in
            if let error = error {
                print("Error deleting transaction: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.transactions.removeAll { $0.id == transaction.id }
                }
            }
        }
    }
}

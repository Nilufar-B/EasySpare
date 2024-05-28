//  GraphView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-10.
//


import SwiftUI
import Charts

struct GraphView: View {
    @StateObject private var transactionManager = TransactionManager()
    @State private var selectedInterval: CustomTimeInterval = .week
    @State private var selectedDate: Date = Date()
    
    var userId: String
    
    var body: some View {
        VStack {
            Picker("Time Interval", selection: $selectedInterval) {
                ForEach(CustomTimeInterval.allCases, id: \.self) { interval in
                    Text(interval.rawValue).tag(interval)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Conditionally display DatePicker when the selected interval is week
            if selectedInterval == .week {
                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding()
            }
            
            Chart {
                if selectedInterval == .month {
                    let monthlyTransactions = transactionManager.processMonthlyTransactions(for: selectedDate)
                    ForEach(monthlyTransactions, id: \.month) { month in
                        BarMark(
                            x: .value("Month", transactionManager.monthName(from: month.month)),
                            y: .value("Income", month.income)
                        )
                        .foregroundStyle(by: .value("Category", "Income"))
                        
                        BarMark(
                            x: .value("Month", transactionManager.monthName(from: month.month)),
                            y: .value("Expense", month.expense)
                        )
                        .foregroundStyle(by: .value("Category", "Expense"))
                    }
                } else {
                    let transactions = transactionManager.processTransactions(for: selectedInterval, selectedDate: selectedDate)
                    ForEach(transactions, id: \.id) { transaction in
                        BarMark(
                            x: .value("Day", transactionManager.weekdayName(from: transaction.dateAdded)),
                            y: .value("Amount", transaction.amount)
                        )
                        .foregroundStyle(by: .value("Category", transaction.category.rawValue))
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) { _ in
                    AxisValueLabel()
                }
            }
            .chartXScale(domain: selectedInterval == .month ? DateFormatter().shortMonthSymbols : ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
            .padding()
            
            Spacer()
        }
        .onAppear {
            transactionManager.fetchTransactions(userId: userId) {}
        }
        .onChange(of: selectedInterval, initial: true) { _, _ in
            transactionManager.fetchTransactions(userId: userId) {}
        }
        .onChange(of: selectedDate, initial: true) { _, _ in
            transactionManager.fetchTransactions(userId: userId) {}
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(userId: "exampleUserId")
    }
}

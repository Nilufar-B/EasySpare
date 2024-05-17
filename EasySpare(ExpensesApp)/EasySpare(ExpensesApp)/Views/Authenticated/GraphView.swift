//
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

            Chart {
                ForEach(transactionManager.processTransactions(for: selectedInterval, selectedDate: selectedDate), id: \.id) { transaction in
                    BarMark(
                        x: .value("Day", transactionManager.weekdayName(from: transaction.dateAdded)),
                        y: .value("Amount", transaction.amount)
                    )
                    .foregroundStyle(by: .value("Category", transaction.category.rawValue))
                }
            }
            .padding()

            Spacer()
        }
        .onAppear {
            transactionManager.fetchTransactions(userId: userId) {}
        }
        .onChange(of: selectedInterval, initial: true) { _, newInterval in
            transactionManager.fetchTransactions(userId: userId) {}
               }
               .onChange(of: selectedDate, initial: true) { _, newDate in
                   transactionManager.fetchTransactions(userId: userId) {}
               }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(userId: "exampleUserId")
    }
}

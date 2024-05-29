//  ExpensesView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-07.
//

import SwiftUI

struct ExpensesView: View {
    @StateObject private var transactionManager = TransactionManager()
    
    @State private var startDate: Date = Date().startMonth
    @State private var endDate: Date = Date().endMonth
    @State private var showFilterView: Bool = false
    @State private var selectedCategory: Category = .expense
    @State private var showEditTransactionView: Bool = false
    @State private var transactionToEdit: Transactions?
    @Namespace private var animation
    
    var userId: String
    var userEmail: String
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 0) {
                    VStack(spacing: 10) {
                        HeaderView(size: .init(width: UIScreen.main.bounds.width, height: 70), userId: userId, onSave: {
                            transactionManager.fetchTransactions(userId: userId) {}
                        })
                        .background(Color.white)
                        .zIndex(1)
                        
                        Button(action: {
                            showFilterView = true
                        }) {
                            HStack {
                                Text("\(startDate.format(date: startDate, format: "dd - MMM yy")) to")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                Text("\(endDate.format(date: endDate, format: "dd - MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .hSpacing(.leading)
                        .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            CardView(income: transactionManager.calculateIncome(), expense: transactionManager.calculateExpense())
                                .padding(.horizontal)
                            
                            CustomSegmentedControl(selectedCategory: $selectedCategory, namespace: animation)
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 10)
                    }
                    .background(Color.white)
                    .shadow(radius: 5)
                    
                    List {
                        ForEach(transactionManager.filteredTransactions(startDate: startDate, endDate: endDate, category: selectedCategory)) { transaction in
                            TransaktionCardView(transaktion: transaction)
                                .onTapGesture {
                                    transactionToEdit = transaction
                                    showEditTransactionView = true
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        transactionManager.deleteTransaction(userId: userId, transaction: transaction)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                .padding(.horizontal)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                .background(Color.gray.opacity(0.15))
                .onAppear {
                    transactionManager.fetchTransactions(userId: userId) {}
                }
                .sheet(isPresented: $showEditTransactionView) {
                    if let transactionToEdit = transactionToEdit {
                        EditTransactionView(isPresented: $showEditTransactionView, userId: userId, transaction: transactionToEdit) {
                            transactionManager.fetchTransactions(userId: userId) {}
                        }
                    }
                }
            }
            .overlay {
                if showFilterView {
                    DateFilterView(start: startDate, end: endDate, onSubmit: { start, end in
                        startDate = start
                        endDate = end
                        showFilterView = false
                    }, onClose: {
                        showFilterView = false
                    }, onReset: {
                        startDate = Date().startMonth
                        endDate = Date().endMonth
                        showFilterView = false
                    })
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.snappy, value: showFilterView)
        }
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(userId: "exampleUserId", userEmail: "example@example.com")
    }
}

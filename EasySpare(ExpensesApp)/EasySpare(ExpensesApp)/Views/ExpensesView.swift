//
//  ExpensesView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-07.
//
import SwiftUI

struct ExpensesView: View {
    @AppStorage("userName") private var userName: String = ""
    
    @State private var startDate: Date = Date().startMonth
    @State private var endDate: Date = Date().endMonth
    @State private var showFilterView: Bool = false
    @State private var selectedCategory: Category = .expense
    @State private var transactions: [Transactions] = []
    @Namespace private var animation
    
    var userId: String
    
    var body: some View {
        GeometryReader{ geometry in
            
            NavigationView {
                List {
                    Section {
                        Button(action: {
                            showFilterView = true
                        }, label: {
                            HStack{
                                Text("\(startDate.format(date: startDate, format: "dd - MMM yy")) to")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                Text("\(endDate.format(date: endDate, format: "dd - MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            }
                        })
                        .hSpacing(.leading)
                        
                        CardView(income: calculateIncome(), expense: calculateExpense())
                        CustomSegmentedControl(selectedCategory: $selectedCategory, namespace: animation)
                        
                        ForEach(sampleTransactions.filter({$0.category == selectedCategory.rawValue })) { transaktion in
                            TransaktionCardView(transaktion: transaktion)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        // Добавить логику удаления
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    } header: {
                        HeaderView(size: .init(width: UIScreen.main.bounds.width, height: 70), userId: userId, onSave: fetchTransactions)
                    }
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 8 : 0)
                .disabled(showFilterView)
                .onAppear {
                    fetchTransactions()
                }
            }
            .overlay{
                    if showFilterView {
                        DateFilterView(start: startDate, end: endDate, onSubmit: {   start, end in
                          startDate = start
                          endDate = end
                            showFilterView = false
                        }, onClose: {
                            showFilterView = false
                        })
                            .transition(.move(edge: .leading))
                }
            }
            .animation(.snappy, value: showFilterView)
        }
    }
    func fetchTransactions() {
        FirestoreManager.shared.fetchTransactions(userId: userId) { fetchedTransactions in
            transactions = fetchedTransactions.filter { !$0.amount.isNaN }
        }
    }

    func calculateIncome() -> Double {
         transactions.filter { $0.category == Category.income.rawValue }.reduce(0) { $0 + $1.amount }
     }
     
     func calculateExpense() -> Double {
         transactions.filter { $0.category == Category.expense.rawValue }.reduce(0) { $0 + $1.amount }
     }
 }

#Preview {
    ExpensesView(userId: "exampleUserId")
}

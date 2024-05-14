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
    @State private var selectedCategory: Category = .expense
    @Namespace private var animation
    
    var body: some View {
        GeometryReader{ geometry in
            
            NavigationView {
                List {
                    Section {
                        Button(action: {
                            
                        }, label: {
                            Text("\(startDate.format(date: startDate, format: "dd - MMM yy")) to")
                                .font(.caption2)
                                .foregroundStyle(.gray)
                            Text("\(endDate.format(date: endDate, format: "dd - MMM yy"))")
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        })
                        .hSpacing(.leading)
                        
                        CardView(income: 2039, expense: 4098)
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
                        HeaderView(size: .init(width: UIScreen.main.bounds.width, height: 70))
                    }
                }
                .refreshable {
                    // Добавить логику обновления данных
                }
            }
        }
    }
}

#Preview {
    ExpensesView()
}

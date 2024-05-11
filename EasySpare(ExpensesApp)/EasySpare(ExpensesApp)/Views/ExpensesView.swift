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
    
    var body: some View {
        GeometryReader{ geometry in
           // let size = $0.size
            
            NavigationStack{
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section {
                            HStack {
                                Text("\(startDate.format(date: startDate, format: "dd - MMM yy")) to")
                                        .font(.caption2)
                                        .foregroundStyle(.gray)
                                Text("\(endDate.format(date: endDate, format: "dd - MMM yy"))")
                                        .font(.caption2)
                                        .foregroundStyle(.gray)
                                }
                            .hSpacing(.leading)
                        } header: {
                            HeaderView(size: geometry.size)
                        }
                    }
                    .padding(15)
                }
            }
        }
    }
}


#Preview {
    ExpensesView()
}

//
//  SearchView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-10.
//

import SwiftUI
import Combine

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var filterText: String = ""
    let searchPublisher = PassthroughSubject<String, Never>()
  
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                LazyHStack(spacing: 12) {
                    
                }
            }
            .overlay(content: {
                ContentUnavailableView("Filter your transactions", systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1 : 0)
            })
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    filterText = ""
                }
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filterText = text
            })
            .searchable(text: $searchText)
            .navigationTitle("Filter")
            .background(.gray.opacity(0.15))
            }
        }
    }


#Preview {
    SearchView()
}

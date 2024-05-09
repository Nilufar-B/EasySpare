//
//  TabView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-09.
//

import SwiftUI

enum Tab: String {
    case recents = "Recents"
    case search = "Filter"
    case charts = "Charts"
    case settings = "Settings"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .recents:
            Image(systemName: "homekit")
            Text(self.rawValue)
        case .search:
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
            
        case .charts:
            Image(systemName: "chart.bar.xaxis.ascending.badge.clock")
            Text(self.rawValue)
            
        case .settings:
            Image(systemName: "gear")
            Text(self.rawValue)
        }
    }
}

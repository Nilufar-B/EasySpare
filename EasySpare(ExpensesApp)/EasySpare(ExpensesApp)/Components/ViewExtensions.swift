//
//  SwiftUIView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-10.
//

import SwiftUI

extension View {
    
    
    // Custom view builder function to create a row with an image, title, and description
    @ViewBuilder
    func FunctionView(symbol: String, title: String, description: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: symbol)
                .font(.title)
                .foregroundColor(appTint)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(Font.custom("JosefinSans-Bold", size: 20))
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
    
    // Custom view builder function to create a horizontally spaced view
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    // Custom view builder function to create a vertically spaced view
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
   
    // Computed property to get the safe area insets of the current window
    var safeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
    }
    
    
    // Function to calculate the opacity of a header based on the scroll position
    func headerOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }
    
    // Function to calculate the scale of a header based on the scroll position
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY / screenHeight
        let scale = (min(max(progress, 0), 1)) * 0.3
        
        return 1 + scale
    }
    
    func currencyString(_ value: Double, allowedDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = allowedDigits
        
        return formatter.string(from: .init(value: value)) ?? ""
    }
    
}

extension Date {
    // Computed property to get the start of the month for a given date
    var startMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        
        return calendar.date(from: components) ?? self // Return the start of the month or self if conversion fails
    }
    
    var endMonth: Date {
        let calendar = Calendar.current
        
        return calendar.date(byAdding: .init(month: 1, minute: -1), to: self.startMonth) ?? self
    }
    // Function to format a date into a string with the specified format
    func format(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format // Set date format
        return dateFormatter.string(from: date) // Return formatted date string
    }
    
    
}



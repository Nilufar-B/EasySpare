//
//  TransaktionCardView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-13.
//

import SwiftUI

struct TransaktionCardView: View {
    var transaktion: Transactions
    var body: some View {
        HStack(spacing:12) {
            Text("\(String(transaktion.title.prefix(1)))")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 45, height: 45)
                .background(transaktion.color.gradient, in: .circle)
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(transaktion.title)
                    .foregroundStyle(Color.primary)
                
                Text(transaktion.remarks)
                    .font(.caption)
                    .foregroundStyle(Color.primary.secondary)
                
                Text(transaktion.dateAdded.format(date: transaktion.dateAdded, format: "dd MMM yyyy"))


                    .font(.caption2)
                    .foregroundStyle(.gray)
            })
            .lineLimit(1)
            .hSpacing(.leading)
            
            Text(currencyString(transaktion.amount, allowedDigits: 1))
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(.background, in: .rect(cornerRadius: 10))
    }
}

struct TransaktionCardView_Previews: PreviewProvider {
    static var previews: some View {
        TransaktionCardView(transaktion: Transactions(
            title: "Sample Transaction",
            remarks: "Sample remarks",
            amount: 123.45,
            dateAdded: Date(),
            category: .expense,
            tintColor: tints.first!.color
        ))
        .previewLayout(.sizeThatFits)
    }
}



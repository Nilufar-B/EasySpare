//  DateFilterView.swift
//  EasySpare(ExpensesApp)
//
//  Created by Nilufar Bakhridinova on 2024-05-14.
//


import SwiftUI

struct DateFilterView: View {
    @State var start: Date
    @State var end: Date
    var onSubmit: (Date, Date) -> Void
    var onClose: () -> Void
    var onReset: () -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 15) {
                DatePicker("Start Date", selection: $start, displayedComponents: [.date])
                DatePicker("End Date", selection: $end, displayedComponents: [.date])
                
                HStack(spacing: 15) {
                    Button("Cancel") {
                        onClose()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 5))
                    .tint(.red)
                    .frame(maxWidth: geometry.size.width * 0.25)

                    Button("Filter") {
                        onSubmit(start, end)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 5))
                    .tint(appTint)
                    .frame(maxWidth: geometry.size.width * 0.25)

                    Button("Reset") {
                        onReset()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 5))
                    .tint(.blue)
                    .frame(maxWidth: geometry.size.width * 0.25)
                }
                .padding(.top, 10)
            }
            .padding(15)
            .background(.bar, in: RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 30)
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct DateFilterView_Previews: PreviewProvider {
    static var previews: some View {
        DateFilterView(
            start: Date(),
            end: Date().addingTimeInterval(60 * 60 * 24 * 7),  // One week later
            onSubmit: { _, _ in },
            onClose: {},
            onReset: {}
        )
    }
}

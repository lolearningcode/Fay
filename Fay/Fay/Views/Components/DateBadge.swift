//
//  DateBadge.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//

import SwiftUI

struct DateBadge: View {
    let date: Date
    
    var body: some View {
        VStack(spacing: 2) {
            Text(date.toMonthAbbreviation())
                .font(.caption)
                .foregroundColor(.blue)
                .accessibilityLabel("Month \(date.toMonthAbbreviation())")
            
            Text(date.toDay())
                .font(.title2)
                .bold()
                .accessibilityLabel("Day \(date.toDay())")
        }
        .multilineTextAlignment(.center)
    }
}

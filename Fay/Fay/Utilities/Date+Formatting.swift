//
//  Date+Formatting.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//

import Foundation

extension Date {
    func toMonthAbbreviation() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM"
        return formatter.string(from: self).uppercased()
    }
    
    func toDay() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
    func toTimeRange(until endDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "h:mm a"
        let start = formatter.string(from: self)
        let end = formatter.string(from: endDate)
        if let abbreviation = TimeZone.current.abbreviation() {
            return "\(start) - \(end) (\(abbreviation))"
        } else {
            return "\(start) - \(end)"
        }
    }
}

//
//  Appointment.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import Foundation

struct Appointment: Identifiable {
    let id: String
    let start: Date
    let end: Date
    let type: String
    let provider: String

    static func mockData() -> [Appointment] {
        let formatter = ISO8601DateFormatter()
        return [
            Appointment(id: "1", start: formatter.date(from: "2025-11-08T19:00:00Z")!, end: formatter.date(from: "2025-11-08T20:00:00Z")!, type: "Follow-up", provider: "Jane Williams, RD"),
            Appointment(id: "2", start: formatter.date(from: "2025-11-24T19:00:00Z")!, end: formatter.date(from: "2025-11-24T20:00:00Z")!, type: "Follow-up", provider: "Jane Williams, RD"),
            Appointment(id: "3", start: formatter.date(from: "2025-10-16T19:00:00Z")!, end: formatter.date(from: "2025-10-16T20:00:00Z")!, type: "Follow-up", provider: "Jane Williams, RD")
        ]
    }
}
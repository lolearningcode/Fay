//
//  Appointment.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import Foundation

struct AppointmentResponse: Codable {
    let appointments: [Appointment]
}

struct Appointment: Codable, Identifiable {
    var id: String { appointmentID }
    
    let appointmentID: String
    let patientID: String
    let providerID: String
    let status: String
    let appointmentType: String
    let start: Date
    let end: Date
    let durationInMinutes: Int
    let recurrenceType: String
    
    enum CodingKeys: String, CodingKey {
        case appointmentID = "appointment_id"
        case patientID = "patient_id"
        case providerID = "provider_id"
        case status
        case appointmentType = "appointment_type"
        case start
        case end
        case durationInMinutes = "duration_in_minutes"
        case recurrenceType = "recurrence_type"
    }
}

extension Appointment {
    static func mock(
        id: String = "demo1",
        start: Date = Date(),
        end: Date = Date().addingTimeInterval(3600),
        appointmentType: String = "Follow-up",
        provider: String = "Jane Williams, RD"
    ) -> Appointment {
        return Appointment(
            appointmentID: id,
            patientID: "1",
            providerID: "100",
            status: "Scheduled",
            appointmentType: appointmentType,
            start: start,
            end: end,
            durationInMinutes: 60,
            recurrenceType: "Weekly"
        )
    }
}

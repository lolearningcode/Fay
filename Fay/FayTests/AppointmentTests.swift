//
//  AppointmentTests.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import XCTest
@testable import Fay

final class AppointmentTests: XCTestCase {

    func testAppointmentDecoding() throws {
        let json = """
        {
            "appointments": [
                {
                    "appointment_id": "test123",
                    "patient_id": "1",
                    "provider_id": "100",
                    "status": "Scheduled",
                    "appointment_type": "Follow-up",
                    "start": "2025-08-10T10:45:00Z",
                    "end": "2025-08-10T11:30:00Z",
                    "duration_in_minutes": 45,
                    "recurrence_type": "Weekly"
                }
            ]
        }
        """.data(using: .utf8)!

        // Decode using ISO8601 date strategy
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let result = try decoder.decode(AppointmentResponse.self, from: json)
        let appointment = result.appointments.first!

        // Assertions
        XCTAssertEqual(appointment.appointmentID, "test123")
        XCTAssertEqual(appointment.patientID, "1")
        XCTAssertEqual(appointment.providerID, "100")
        XCTAssertEqual(appointment.status, "Scheduled")
        XCTAssertEqual(appointment.appointmentType, "Follow-up")
        XCTAssertEqual(appointment.durationInMinutes, 45)
        XCTAssertEqual(appointment.recurrenceType, "Weekly")

        let calendar = Calendar(identifier: .gregorian)
        var utcCalendar = calendar
        utcCalendar.timeZone = TimeZone(secondsFromGMT: 0)! // Force UTC
        
        let components = utcCalendar.dateComponents([.year, .month, .day, .hour], from: appointment.start)
        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 8)
        XCTAssertEqual(components.day, 10)
        XCTAssertEqual(components.hour, 10)
    }
}

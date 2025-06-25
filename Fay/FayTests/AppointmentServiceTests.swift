//
//  AppointmentServiceTests.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import XCTest
@testable import Fay

private class MockNetworkClient: NetworkClient {
    var mockAppointments: [Appointment] = []
    
    func get<T>(_ url: URL, headers: [String: String], as type: T.Type) async throws -> T where T : Decodable {
        let response = AppointmentResponse(appointments: mockAppointments)
        return response as! T
    }
}

private class FailingNetworkClient: NetworkClient {
    func get<T>(_ url: URL, headers: [String : String], as type: T.Type) async throws -> T where T : Decodable {
        throw URLError(.cannotParseResponse)
    }
}

final class AppointmentServiceTests: XCTestCase {

    func testFetchAppointmentsReturnsData() async throws {
        let mockClient = MockNetworkClient()
        mockClient.mockAppointments = [
            Appointment(
                appointmentID: "test1",
                patientID: "1",
                providerID: "100",
                status: "Scheduled",
                appointmentType: "Follow-up",
                start: ISO8601DateFormatter().date(from: "2025-08-10T10:45:00Z")!,
                end: ISO8601DateFormatter().date(from: "2025-08-10T11:30:00Z")!,
                durationInMinutes: 45,
                recurrenceType: "Weekly"
            )
        ]

        let service = AppointmentService(networkClient: mockClient)
        let appointments = try await service.fetchAppointments()

        XCTAssertEqual(appointments.count, 1)
        XCTAssertEqual(appointments.first?.appointmentID, "test1")
    }
    
    func testFetchAppointmentsWithEmptyListReturnsEmptyArray() async throws {
        let mockClient = MockNetworkClient()
        mockClient.mockAppointments = []
        
        let service = AppointmentService(networkClient: mockClient)
        let appointments = try await service.fetchAppointments()
        
        XCTAssertTrue(appointments.isEmpty, "Expected no appointments")
    }
    
    func testFetchAppointmentsWithMultipleItems() async throws {
        let mockClient = MockNetworkClient()
        mockClient.mockAppointments = [
            Appointment(
                appointmentID: "a1",
                patientID: "1",
                providerID: "100",
                status: "Scheduled",
                appointmentType: "Follow-up",
                start: Date(),
                end: Date().addingTimeInterval(3600),
                durationInMinutes: 60,
                recurrenceType: "Weekly"
            ),
            Appointment(
                appointmentID: "a2",
                patientID: "1",
                providerID: "100",
                status: "Occurred",
                appointmentType: "Initial consultation",
                start: Date().addingTimeInterval(-7200),
                end: Date().addingTimeInterval(-3600),
                durationInMinutes: 60,
                recurrenceType: "None"
            )
        ]
        
        let service = AppointmentService(networkClient: mockClient)
        let appointments = try await service.fetchAppointments()
        
        XCTAssertEqual(appointments.count, 2)
        XCTAssertEqual(appointments[1].status, "Occurred")
        XCTAssertEqual(appointments[0].recurrenceType, "Weekly")
    }
    
    func testFetchAppointmentsThrowsOnDecodeFailure() async {
        let failingClient = FailingNetworkClient()
        let service = AppointmentService(networkClient: failingClient)
        
        do {
            _ = try await service.fetchAppointments()
            XCTFail("Expected failure but got success")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}

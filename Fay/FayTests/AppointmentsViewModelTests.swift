//
//  AppointmentsViewModelTests.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import XCTest
@testable import Fay

private class MockAppointmentService: AppointmentService {
    var shouldThrow = false
    var mockAppointments: [Appointment] = []
    
    override func fetchAppointments() async throws -> [Appointment] {
        if shouldThrow {
            throw URLError(.badServerResponse)
        }
        return mockAppointments
    }
}

final class AppointmentsViewModelTests: XCTestCase {

    func testLoadAppointmentsSuccess() async {
        let mockService = MockAppointmentService()
        mockService.mockAppointments = [
            Appointment(
                appointmentID: "a1",
                patientID: "1",
                providerID: "100",
                status: "Scheduled",
                appointmentType: "Follow-up",
                start: Date().addingTimeInterval(3600), // future
                end: Date().addingTimeInterval(7200),
                durationInMinutes: 60,
                recurrenceType: "Weekly"
            )
        ]

        let viewModel = AppointmentsViewModel(service: mockService)

        await viewModel.loadAppointments()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.appointments.count, 1)
    }

    func testLoadAppointmentsFailure() async {
        let mockService = MockAppointmentService()
        mockService.shouldThrow = true

        let viewModel = AppointmentsViewModel(service: mockService)

        await viewModel.loadAppointments()

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.appointments.isEmpty)
    }

    func testUpcomingAndPastFiltering() {
        let now = Date()
        let past = Appointment(
            appointmentID: "past",
            patientID: "1",
            providerID: "100",
            status: "Occurred",
            appointmentType: "Consultation",
            start: now.addingTimeInterval(-3600),
            end: now.addingTimeInterval(-1800),
            durationInMinutes: 30,
            recurrenceType: "None"
        )
        let future = Appointment(
            appointmentID: "future",
            patientID: "1",
            providerID: "100",
            status: "Scheduled",
            appointmentType: "Follow-up",
            start: now.addingTimeInterval(3600),
            end: now.addingTimeInterval(7200),
            durationInMinutes: 60,
            recurrenceType: "Weekly"
        )

        let viewModel = AppointmentsViewModel(service: MockAppointmentService())
        viewModel.appointments = [past, future]

        XCTAssertEqual(viewModel.pastAppointments.count, 1)
        XCTAssertEqual(viewModel.upcomingAppointments.count, 1)
        XCTAssertEqual(viewModel.pastAppointments.first?.appointmentID, "past")
        XCTAssertEqual(viewModel.upcomingAppointments.first?.appointmentID, "future")
    }
}

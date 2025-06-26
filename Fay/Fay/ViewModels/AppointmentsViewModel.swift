//
//  AppointmentsViewModel.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//

import Foundation

@Observable
class AppointmentsViewModel {
    var appointments: [Appointment] = []
    var isLoading: Bool = false
    var errorMessage: String?

    private let service: AppointmentService
    
    init(service: AppointmentService = AppointmentService()) {
        self.service = service
    }

    func loadAppointments() async {
        isLoading = true
        errorMessage = nil

        do {
            appointments = try await service.fetchAppointments()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    var upcomingAppointments: [Appointment] {
        appointments.filter { $0.start > Date() }
    }

    var pastAppointments: [Appointment] {
        appointments.filter { $0.start <= Date() }
    }
}

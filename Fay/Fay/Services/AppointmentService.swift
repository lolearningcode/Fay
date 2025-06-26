//
//  AppointmentService.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//

import Foundation

class AppointmentService {
    private let networkClient: NetworkClient
    private let baseURL = URL(string: "https://node-api-for-candidates.onrender.com")!

    init(networkClient: NetworkClient = URLSessionClient()) {
        self.networkClient = networkClient
    }

    func fetchAppointments() async throws -> [Appointment] {
        let url = baseURL.appendingPathComponent("/appointments")
        let token = UserDefaults.standard.string(forKey: "authToken") ?? ""
        let headers = ["Authorization": "Bearer \(token)"]

        let response = try await networkClient.get(url, headers: headers, as: AppointmentResponse.self)
        return response.appointments
    }
}

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
    private var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkpvaG4gRG9lIiwidXNlcm5hbWUiOiJqb2huIiwicGFzc3dvcmQiOiIxMjM0NSIsImlhdCI6MTc1MDg5MTcxMn0.93sgTYGbcdKKE1c8vX5ksKy0gakMymf3m8_xqvI7z1Y"

    init(networkClient: NetworkClient = URLSessionClient()) {
        self.networkClient = networkClient
    }

    func fetchAppointments() async throws -> [Appointment] {
        let url = baseURL.appendingPathComponent("/appointments")
        let headers = ["Authorization": "Bearer \(token)"]

        let response = try await networkClient.get(url, headers: headers, as: AppointmentResponse.self)
        return response.appointments
    }
}

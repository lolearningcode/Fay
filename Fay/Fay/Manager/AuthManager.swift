//
//  AuthManager.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import Foundation

protocol AuthService {
    func login(username: String, password: String) async throws -> String
}

final class RemoteAuthService: AuthService {
    private let url = URL(string: "https://node-api-for-candidates.onrender.com/signin")!
    
    func login(username: String, password: String) async throws -> String {
        let payload = ["username": username, "password": password]
        let body = try JSONEncoder().encode(payload)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw LoginError.invalidCredentials
        }
        
        let token = try JSONDecoder().decode(TokenResponse.self, from: data).token
        return token
    }
    
    private struct TokenResponse: Decodable {
        let token: String
    }
    
    enum LoginError: LocalizedError {
        case invalidCredentials
        var errorDescription: String? {
            "Invalid credentials"
        }
    }
}

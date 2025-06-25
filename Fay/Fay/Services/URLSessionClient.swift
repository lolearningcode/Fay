//
//  URLSessionClient.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//

import Foundation

protocol NetworkClient {
    func get<T: Decodable>(_ url: URL, headers: [String: String], as type: T.Type) async throws -> T
}

class URLSessionClient: NetworkClient {
    func get<T: Decodable>(_ url: URL, headers: [String: String], as type: T.Type) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(T.self, from: data)
    }
}

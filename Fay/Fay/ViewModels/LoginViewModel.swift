//
//  LoginViewModel.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//

import Foundation

@Observable
class LoginViewModel {
    var username: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    var isLoggedIn: Bool = false
    var token: String?

    private let authService: AuthService

    init(authService: AuthService = RemoteAuthService()) {
        self.authService = authService
    }

    func login() async {
        isLoading = true
        errorMessage = nil

        do {
            let token = try await authService.login(username: username, password: password)
            self.token = token
            UserDefaults.standard.set(token, forKey: "authToken")
            self.isLoggedIn = true
        } catch {
            self.errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

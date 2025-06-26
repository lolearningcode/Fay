//
//  LoginViewModelTests.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import XCTest
@testable import Fay

private class MockAuthService: AuthService {
    var shouldFail = false
    var expectedToken = "mock-token"
    
    func login(username: String, password: String) async throws -> String {
        if shouldFail {
            throw RemoteAuthService.LoginError.invalidCredentials
        }
        return expectedToken
    }
}

final class LoginViewModelTests: XCTestCase {

    func testLoginSuccess() async {
        let mockService = MockAuthService()
        mockService.expectedToken = "abc123"
        let viewModel = LoginViewModel(authService: mockService)
        viewModel.username = "john"
        viewModel.password = "12345"

        await viewModel.login()

        XCTAssertTrue(viewModel.isLoggedIn)
        XCTAssertEqual(viewModel.token, "abc123")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoginFailure() async {
        let mockService = MockAuthService()
        mockService.shouldFail = true
        let viewModel = LoginViewModel(authService: mockService)
        viewModel.username = "wrong"
        viewModel.password = "wrong"

        await viewModel.login()

        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertNil(viewModel.token)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoginClearsOldErrorState() async {
        let mockService = MockAuthService()
        mockService.shouldFail = true
        let viewModel = LoginViewModel(authService: mockService)
        viewModel.errorMessage = "Old error"
        viewModel.username = "wrong"
        viewModel.password = "wrong"

        await viewModel.login()

        XCTAssertNotEqual(viewModel.errorMessage, "Old error")
    }
    
    func testRealLoginRequest() async throws {
        let authService = RemoteAuthService()
        let token = try await authService.login(username: "john", password: "12345")
        XCTAssertFalse(token.isEmpty)
    }
}

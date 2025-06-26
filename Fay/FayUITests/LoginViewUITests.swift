//
//  LoginViewUITests.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import XCTest

final class LoginViewUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testLoginScreenElementsExist() {
        let usernameField = app.textFields["usernameField"]
        let passwordField = app.secureTextFields["passwordField"]
        let signInButton = app.buttons["signInButton"]

        XCTAssertTrue(usernameField.exists)
        XCTAssertTrue(passwordField.exists)
        XCTAssertTrue(signInButton.exists)
    }

    func testLoginButtonDisabledInitially() {
        let signInButton = app.buttons["signInButton"]
        XCTAssertFalse(signInButton.isEnabled)
    }

    func testLoginButtonEnabledAfterInput() {
        let usernameField = app.textFields["usernameField"]
        let passwordField = app.secureTextFields["passwordField"]
        let signInButton = app.buttons["signInButton"]

        usernameField.tap()
        usernameField.typeText("john")

        passwordField.tap()
        passwordField.typeText("12345")

        XCTAssertTrue(signInButton.isEnabled)
    }
    
    func testBadLoginShowsError() {
        let usernameField = app.textFields["usernameField"]
        let passwordField = app.secureTextFields["passwordField"]
        let signInButton = app.buttons["signInButton"]
        
        usernameField.tap()
        usernameField.typeText("wronguser")
        
        passwordField.tap()
        passwordField.typeText("wrongpass")
        
        signInButton.tap()
        
        let errorLabel = app.staticTexts["errorMessage"]
        
        // Wait up to 5 seconds for the error to appear
        let exists = errorLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Error message did not appear for invalid login")
    }
    
    func testSuccessfulLoginNavigatesToAppointments() {
        let usernameField = app.textFields["usernameField"]
        let passwordField = app.secureTextFields["passwordField"]
        let signInButton = app.buttons["signInButton"]
        
        usernameField.tap()
        usernameField.typeText("john") // valid test user
        
        passwordField.tap()
        passwordField.typeText("12345") // valid test password
        
        signInButton.tap()
        
        let appointmentsTitle = app.staticTexts["appointmentsTitle"]
        
        let appeared = appointmentsTitle.waitForExistence(timeout: 10)
        XCTAssertTrue(appeared, "Failed to navigate to Appointments screen after login")
    }
}

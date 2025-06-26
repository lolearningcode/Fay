//
//  LoginView.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import SwiftUI

struct LoginView: View {
    @Bindable var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("Sign In")
                .font(.largeTitle)
                .bold()

            VStack(spacing: 16) {
                TextField("Username", text: $viewModel.username)
                    .accessibilityIdentifier("usernameField")
                    .autocapitalization(.none)
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $viewModel.password)
                    .accessibilityIdentifier("passwordField")
                    .textFieldStyle(.roundedBorder)
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .accessibilityIdentifier("errorMessage")
            }

            if viewModel.isLoading {
                ProgressView()
            } else {
                Button(action: {
                    Task {
                        await viewModel.login()
                    }
                }) {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .accessibilityIdentifier("signInButton")
                .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty)
            }

            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let mockVM = LoginViewModel()
        mockVM.username = "john"
        mockVM.password = "12345"
        mockVM.errorMessage = nil
        mockVM.isLoading = false
        
        return Group {
            LoginView(viewModel: mockVM)
                .previewDisplayName("Light Mode")
                .preferredColorScheme(.light)
                .previewDevice("iPhone 14 Pro")
            
            LoginView(viewModel: mockVM)
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 14 Pro")
        }
    }
}

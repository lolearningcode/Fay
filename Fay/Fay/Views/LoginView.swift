//
//  LoginView.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import SwiftUI

struct LoginView: View {
    @Bindable var viewModel: LoginViewModel
    @State private var isSecure = true
    @State private var shakeOffset: CGFloat = 0
    @FocusState private var focusedField: Field?
    @State private var logoBounce = false
    
    enum Field {
        case username, password
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Animated Logo Symbol
            Image(systemName: "calendar")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.blue)
                .scaleEffect(logoBounce ? 1.2 : 1.0)
                .rotationEffect(.degrees(logoBounce ? 8 : -8))
                .animation(
                    .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                    value: logoBounce
                )
                .accessibilityHidden(true)
            
            Text("Sign In")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 16) {
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .username)
                    .accessibilityIdentifier("usernameField")
                
                HStack {
                    Group {
                        if isSecure {
                            SecureField("Password", text: $viewModel.password)
                        } else {
                            TextField("Password", text: $viewModel.password)
                        }
                    }
                    .focused($focusedField, equals: .password)
                    .accessibilityIdentifier("passwordField")
                    
                    Button(action: { isSecure.toggle() }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .accessibilityLabel("Toggle password visibility")
                }
                .textFieldStyle(.roundedBorder)
            }
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .accessibilityIdentifier("errorMessage")
                    .transition(.opacity)
                    .offset(x: shakeOffset)
                    .onChange(of: viewModel.errorMessage) {
                        withAnimation(.default) {
                            shakeOffset = 12
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.default) {
                                shakeOffset = 0
                            }
                        }
                    }
            }
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button(action: {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
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
                .opacity(viewModel.username.isEmpty || viewModel.password.isEmpty ? 0.5 : 1)
                .animation(.easeInOut, value: viewModel.username + viewModel.password)
            }
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color(.systemBackground), Color(.systemGray6)],
                startPoint: .top, endPoint: .bottom
            )
        )
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear {
            focusedField = .username
            logoBounce = true
        }
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

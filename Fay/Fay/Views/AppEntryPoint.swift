//
//  AppEntryPoint.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//

import SwiftUI

struct AppEntryPoint: View {
    @State private var loginViewModel = LoginViewModel()

    var body: some View {
        if loginViewModel.isLoggedIn {
            AppointmentsView(viewModel: AppointmentsViewModel())
        } else {
            LoginView(viewModel: loginViewModel)
        }
    }
}

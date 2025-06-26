//
//  AppointmentsView.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import SwiftUI

struct AppointmentsView: View {
    enum TabSelection: String, CaseIterable {
        case upcoming = "Upcoming"
        case past = "Past"
    }

    @State private var selectedTab: TabSelection = .upcoming

    @Bindable var viewModel: AppointmentsViewModel
    
    init(viewModel: AppointmentsViewModel) {
        _viewModel = Bindable(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading appointments...")
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            } else {
                header
                tabSwitcher
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(filteredAppointments) { appointment in
                            AppointmentCardView(
                                appointment: appointment,
                                isFirst: isFirstUpcoming(appointment)
                            )
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadAppointments()
            }
        }
    }

    private var header: some View {
        HStack {
            Text("Appointments")
                .font(.largeTitle)
                .bold()
                .accessibilityIdentifier("appointmentsTitle")
            Spacer()
            Button(action: {}) {
                HStack {
                    Image(systemName: "plus")
                    Text("New")
                }
            }
        }
        .padding([.horizontal, .top])
    }

    private var tabSwitcher: some View {
        Picker("Tab", selection: $selectedTab) {
            ForEach(TabSelection.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }

    private var filteredAppointments: [Appointment] {
        selectedTab == .upcoming
        ? viewModel.upcomingAppointments
        : viewModel.pastAppointments
    }

    private func isFirstUpcoming(_ appointment: Appointment) -> Bool {
        selectedTab == .upcoming &&
        appointment.id == filteredAppointments.first?.id
    }
}

struct AppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        let mockAppointments = [
            Appointment(
                appointmentID: "a1",
                patientID: "1",
                providerID: "100",
                status: "Scheduled",
                appointmentType: "Follow-up",
                start: Date().addingTimeInterval(3600), // 1 hour from now
                end: Date().addingTimeInterval(7200),
                durationInMinutes: 60,
                recurrenceType: "Weekly"
            ),
            Appointment(
                appointmentID: "a2",
                patientID: "1",
                providerID: "100",
                status: "Occurred",
                appointmentType: "Initial consultation",
                start: Date().addingTimeInterval(-7200), // 2 hours ago
                end: Date().addingTimeInterval(-3600),
                durationInMinutes: 60,
                recurrenceType: "None"
            )
        ]
        
        let mockVM = AppointmentsViewModel()
        mockVM.appointments = mockAppointments // preload mock data
        
        return Group {
            AppointmentsView(viewModel: mockVM)
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
                .previewDevice("iPhone 14 Pro")
            
            AppointmentsView(viewModel: mockVM)
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
                .previewDevice("iPhone 14 Pro")
        }
    }
}

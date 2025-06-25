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

    // Mock Data Placeholder
    @State private var appointments: [Appointment] = Appointment.mockData()

    var body: some View {
        VStack {
            header
            tabSwitcher
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(filteredAppointments) { appointment in
                        AppointmentCardView(appointment: appointment, isFirst: isFirstUpcoming(appointment))
                    }
                }
                .padding()
            }
        }
    }

    private var header: some View {
        HStack {
            Text("Appointments")
                .font(.largeTitle)
                .bold()
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
        let now = Date()
        return appointments.filter {
            selectedTab == .upcoming ? $0.start > now : $0.start <= now
        }
    }

    private func isFirstUpcoming(_ appointment: Appointment) -> Bool {
        selectedTab == .upcoming &&
        appointment.id == filteredAppointments.first?.id
    }
}

struct AppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppointmentsView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
                .previewDevice("iPhone 14 Pro")
            
            AppointmentsView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
                .previewDevice("iPhone 14 Pro")
        }
    }
}

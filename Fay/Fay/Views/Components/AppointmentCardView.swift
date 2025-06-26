//
//  AppointmentCardView.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import SwiftUI

struct AppointmentCardView: View {
    let appointment: Appointment
    let isFirst: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                VStack {
                    Text(appointment.start.toMonthAbbreviation())
                        .font(.caption)
                        .foregroundColor(.blue)
                    Text(appointment.start.toDay())
                        .font(.title2)
                        .bold()
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(appointment.start.toTimeRange(until: appointment.end))")
                        .font(.headline)
                    
                    Text(appointment.appointmentType)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    if isFirst {
                        Button {
                            // TODO: Action
                        } label: {
                            HStack {
                                Image(systemName: "video")
                                Text("Join appointment")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.9))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 6)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct AppointmentCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppointmentCardView(appointment: .mock(), isFirst: true)
                .previewDisplayName("With Join Button")
                .padding()
                .previewLayout(.sizeThatFits)
            
            AppointmentCardView(appointment: .mock(), isFirst: false)
                .previewDisplayName("Without Join Button")
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}

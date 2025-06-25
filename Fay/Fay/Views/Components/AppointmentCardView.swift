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
            HStack {
                VStack {
                    Text(appointment.start.formatted(.dateTime.month(.abbreviated)))
                        .font(.caption)
                        .foregroundColor(.blue)
                    Text(appointment.start.formatted(.dateTime.day()))
                        .font(.title2)
                        .bold()
                }
                .frame(width: 50)
                .padding(.trailing, 8)

                VStack(alignment: .leading) {
                    Text("\(appointment.start.formatted(date: .omitted, time: .shortened)) - \(appointment.end.formatted(date: .omitted, time: .shortened))")
                        .font(.headline)
                    Text("Follow up with \(appointment.provider)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }

            if isFirst {
                Button(action: {}) {
                    HStack {
                        Image(systemName: "video")
                        Text("Join appointment")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct AppointmentCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppointmentCardView(
                appointment: Appointment(
                    id: "1",
                    start: ISO8601DateFormatter().date(from: "2025-11-08T19:00:00Z")!,
                    end: ISO8601DateFormatter().date(from: "2025-11-08T20:00:00Z")!,
                    type: "Follow-up",
                    provider: "Jane Williams, RD"
                ),
                isFirst: true
            )
            .previewDisplayName("With Join Button")
            .padding()
            .previewLayout(.sizeThatFits)
            
            AppointmentCardView(
                appointment: Appointment(
                    id: "2",
                    start: ISO8601DateFormatter().date(from: "2025-11-24T19:00:00Z")!,
                    end: ISO8601DateFormatter().date(from: "2025-11-24T20:00:00Z")!,
                    type: "Follow-up",
                    provider: "Jane Williams, RD"
                ),
                isFirst: false
            )
            .previewDisplayName("Without Join Button")
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }
}

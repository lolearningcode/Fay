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
        HStack(alignment: .top, spacing: 12) {
            // Side accent bar
            Rectangle()
                .fill(isFirst ? Color.blue : Color.gray.opacity(0.3))
                .frame(width: 4)
                .cornerRadius(2)
            
            // Main content
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 12) {
                    DateBadge(date: appointment.start)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(appointment.start.toTimeRange(until: appointment.end))
                            .font(.headline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.85)
                        
                        Text(appointment.appointmentType)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .accessibilityLabel("Appointment type \(appointment.appointmentType)")
                    }
                    
                    Spacer()
                }
                
                if isFirst {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        // TODO: Join action
                    }) {
                        HStack {
                            Image(systemName: "video")
                            Text("Join appointment")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 6)
                    .accessibilityIdentifier("joinAppointmentButton")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
        .frame(maxWidth: .infinity)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut(duration: 0.3), value: isFirst)
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

//
//  ProfileView.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile image
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .shadow(radius: 10)
                    .padding(.top)

                // User info
                Text("Cleo Howard")
                    .font(.title2.bold())

                Text("Therapy Client")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Divider().padding(.horizontal)

                // Info cards
                VStack(spacing: 12) {
                    ProfileRow(icon: "calendar", title: "Next Appointment", value: "July 1, 2025 at 10:00 AM")

                    ProfileRow(icon: "doc.text", title: "Last Session Notes", value: "Focused on managing stress with daily routines.")

                    ProfileRow(icon: "clock", title: "Streak", value: "5 weeks in a row")

                    ProfileRow(icon: "star.fill", title: "Therapist", value: "Jane Williams, RD")
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
                .previewDisplayName("Light Mode")
                .preferredColorScheme(.light)
                .previewDevice("iPhone 14 Pro")
            
            ProfileView()
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 14 Pro")
        }
    }
}

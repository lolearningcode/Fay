//
//  MainTabView.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            AppointmentsView(viewModel: AppointmentsViewModel())
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Appointments")
                }

            Text("Chat")
                .tabItem {
                    Image(systemName: "bubble.left")
                    Text("Chat")
                }

            Text("Journal")
                .tabItem {
                    Image(systemName: "book")
                    Text("Journal")
                }

            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .previewDevice("iPhone 14 Pro")
            .previewDisplayName("Main Tab View")
    }
}

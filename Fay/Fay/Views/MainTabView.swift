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
                    Image("Calendar")
                        .renderingMode(.template)
                    Text("Appointments")
                }

            ChatView()
                .tabItem {
                    Image("Chats")
                        .renderingMode(.template)
                    Text("Chat")
                }

            JournalView()
                .tabItem {
                    Image("Journal")
                        .renderingMode(.template)
                    Text("Journal")
                }

            ProfileView()
                .tabItem {
                    Image("User")
                        .renderingMode(.template)
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

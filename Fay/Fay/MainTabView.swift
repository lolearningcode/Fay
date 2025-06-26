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

            Text("Chat")
                .tabItem {
                    Image("Chats")
                        .renderingMode(.template)
                    Text("Chat")
                }

            Text("Journal")
                .tabItem {
                    Image("Journal")
                        .renderingMode(.template)
                    Text("Journal")
                }

            Text("Profile")
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

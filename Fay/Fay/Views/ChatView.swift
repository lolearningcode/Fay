//
//  ChatView.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import SwiftUI

struct ChatView: View {
    private let messages: [ChatMessage] = [
        ChatMessage(id: 1, isUser: false, text: "Hey Cleo, just checking in before our session tomorrow."),
        ChatMessage(id: 2, isUser: true, text: "Hi Jane! Sounds good. Is it still at 10 AM PST?"),
        ChatMessage(id: 3, isUser: false, text: "Yep, same time. We’ll be covering your progress on journaling."),
        ChatMessage(id: 4, isUser: true, text: "Awesome, I’ve been more consistent this week 🙌"),
        ChatMessage(id: 5, isUser: false, text: "That’s great to hear. See you then! 👋")
    ]

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 12) {
                    Text("Yesterday")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top)

                    ForEach(messages) { message in
                        ChatBubble(message: message)
                    }
                }
                .padding(.horizontal)
            }

            HStack {
                TextField("Type a message...", text: .constant(""))
                    .padding(12)
                    .background(Color(.systemGray6))
                    .clipShape(Capsule())
                    .disabled(true)

                Image(systemName: "paperplane.fill")
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .navigationTitle("Jane Williams")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView()
        }
        .previewDevice("iPhone 14 Pro")
    }
}

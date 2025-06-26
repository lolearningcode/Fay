//
//  ChatMessage.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//

import SwiftUI

struct ChatMessage: Identifiable {
    let id: Int
    let isUser: Bool
    let text: String
}

struct ChatBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser { Spacer() }

            Text(message.text)
                .padding(12)
                .background(message.isUser ? Color.blue : Color(.systemGray5))
                .foregroundColor(message.isUser ? .white : .black)
                .clipShape(ChatBubbleShape(isUser: message.isUser))
                .frame(maxWidth: 250, alignment: message.isUser ? .trailing : .leading)

            if !message.isUser { Spacer() }
        }
        .padding(message.isUser ? .leading : .trailing, 40)
    }
}

struct ChatBubbleShape: Shape {
    let isUser: Bool

    func path(in rect: CGRect) -> Path {
        let path = RoundedRectangle(cornerRadius: 20).path(in: rect)

        return path
    }
}

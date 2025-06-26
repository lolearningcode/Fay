//
//  JournalEntry.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//


import SwiftUI

struct JournalView: View {
    private let entries: [JournalEntry] = [
        JournalEntry(date: "June 24, 2025", title: "Finding Balance", content: "Today I focused on staying present and not overthinking. I went for a walk after work, and it really helped clear my head."),
        JournalEntry(date: "June 23, 2025", title: "Tough Morning", content: "Woke up anxious, but I still made it to the gym. Pushed through the discomfort, and I’m proud of myself for showing up."),
        JournalEntry(date: "June 22, 2025", title: "Small Wins", content: "Had a productive day. Knocked out some small tasks I’ve been putting off. It reminded me how powerful momentum can be.")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(entries) { entry in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(entry.date)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text(entry.title)
                            .font(.headline)
                        
                        Text(entry.content)
                            .font(.body)
                            .lineLimit(3)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Journal")
        }
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
            .previewDevice("iPhone 14 Pro")
    }
}

//
//  JournalEntry.swift
//  Fay
//
//  Created by Cleo Howard on 6/25/25.
//

import Foundation

struct JournalEntry: Identifiable {
    let id = UUID()
    let date: String
    let title: String
    let content: String
}

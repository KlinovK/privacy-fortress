//
//  Leak.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import Foundation

struct Leak: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: String
}

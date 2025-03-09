//
//  PasswordItem.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 09/03/25.
//

import Foundation

struct PasswordItem: Identifiable {
    let id = UUID()
    let domainName: String
    let username: String
    let password: String
}

//
//  PasswordItem.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 09/03/25.
//

import Foundation

struct PasswordItem: Codable, Identifiable, Hashable {
    var id: UUID
    var domain: String
    var username: String
    var password: String
    
    init(domain: String, username: String, password: String) {
        self.id = UUID()
        self.domain = domain
        self.username = username
        self.password = password
    }
    
    static func == (lhs: PasswordItem, rhs: PasswordItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

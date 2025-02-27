//
//  Breach.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 27/02/25.
//

import Foundation

struct Breach: Codable {
    let name: String
    let title: String
    let domain: String
    let breachDate: String
    let addedDate: String
    let modifiedDate: String
    let pwnCount: Int
    let description: String
    let logoPath: String
    let dataClasses: [String]
    let isVerified: Bool
    let isFabricated: Bool
    let isSensitive: Bool
    let isRetired: Bool
    let isSpamList: Bool
    let isMalware: Bool
    let isStealerLog: Bool
    let isSubscriptionFree: Bool
}

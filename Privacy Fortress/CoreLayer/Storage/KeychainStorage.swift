//
//  KeychainStorage.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 07/03/25.
//

import Foundation

protocol KeychainStorage {
    func string(forKey: UserSessionKey) -> String?
    func set(_ value: String?, forKey: UserSessionKey)
    func bool(forKey: UserSessionKey) -> Bool
    func set(_ value: Bool, forKey: UserSessionKey)
    func double(forKey: UserSessionKey) -> Double
    func set(_ value: Double, forKey: UserSessionKey)
    func removeObject(forKey: UserSessionKey)
}

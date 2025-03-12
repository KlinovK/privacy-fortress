//
//  Storage.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 06/03/25.
//

import Foundation

protocol Storage {
    func string(forKey: UserSessionKey) -> String?
    func setString(_ value: String?, forKey: UserSessionKey)
    func bool(forKey: UserSessionKey) -> Bool
    func setBool(_ value: Bool, forKey: UserSessionKey)
    func double(forKey: UserSessionKey) -> Double
    func setDouble(_ value: Double, forKey: UserSessionKey)
    func removeObject(forKey: UserSessionKey)
}

extension UserDefaults: Storage {
    func string(forKey: UserSessionKey) -> String? {
        string(forKey: forKey.rawValue)
    }
    
    func setString(_ value: String?, forKey: UserSessionKey) {
        set(value, forKey: forKey.rawValue)
    }
    
    func bool(forKey: UserSessionKey) -> Bool {
        bool(forKey: forKey.rawValue)
    }
    
    func setBool(_ value: Bool, forKey: UserSessionKey) {
        set(value, forKey: forKey.rawValue)
    }
    
    func double(forKey: UserSessionKey) -> Double {
        double(forKey: forKey.rawValue)
    }
    
    func setDouble(_ value: Double, forKey: UserSessionKey) {
        set(value, forKey: forKey.rawValue)
    }
    
    func removeObject(forKey: UserSessionKey) {
        removeObject(forKey: forKey.rawValue)
    }
}

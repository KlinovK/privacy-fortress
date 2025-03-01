//
//  KeychainWrapper.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation
import SwiftKeychainWrapper

class KeychainWrapperManager {
    
    static let shared = KeychainWrapperManager()
    
    private init() { }

    public func getValue(forKey key: String) -> String? {
        return KeychainWrapper.standard.string(forKey: key)
    }
    
    public func setSecure(value: String?, forKey key: String) {
        if let value = value, !value.isEmpty {
            KeychainWrapper.standard.set(value, forKey: key)
        } else {
            KeychainWrapper.standard.removeObject(forKey: key)
        }
    }
    
    public func setSecure(data: Data?, forKey key: String) {
        if let data = data {
            KeychainWrapper.standard.set(data, forKey: key)
        } else {
            KeychainWrapper.standard.removeObject(forKey: key)
        }
    }
    
    /// Save the HIBP API key securely
    public func saveHIBAPIKey() {
        KeychainWrapper.standard.set("88fa34a9-1453-43ed-a773-80d7b792e670", forKey: Constants.KeychainConstants.kHibpApiKey)
    }

    /// Retrieve the HIBP API key
    public func getHIBPAPIKey() -> String? {
        return KeychainWrapper.standard.string(forKey: Constants.KeychainConstants.kHibpApiKey)
    }

    // Delete the HIBP API key from Keychain
    public func deleteHIBPAPIKey() -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: Constants.KeychainConstants.kHibpApiKey)
    }
}

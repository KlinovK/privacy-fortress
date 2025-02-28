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
    
    private init() {
        _ = saveHIBAPIKey("88fa34a9-1453-43ed-a773-80d7b792e670")
    }
    
    private let hibpApiKey = "HIBP_API_KEY"
    
    func saveHIBAPIKey(_ key: String) -> Bool {
        return KeychainWrapper.standard.set(key, forKey: hibpApiKey)
    }

    func getAPIHIBPKey() -> String? {
        return KeychainWrapper.standard.string(forKey: hibpApiKey)
    }

    func deleteHBIPAPIKey() -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: hibpApiKey)
    }
}

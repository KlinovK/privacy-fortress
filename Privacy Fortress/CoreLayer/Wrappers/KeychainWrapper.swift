//
//  KeychainWrapper.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation
import SwiftKeychainWrapper

final class KeychainWrapperManager: KeychainStorage {
    
    static let shared = KeychainWrapperManager()
    
    private let keychain: KeychainWrapper
    
    private init(keychain: KeychainWrapper = .standard) {
        self.keychain = keychain
    }
    
    func string(forKey: UserSessionKey) -> String? {
        keychain.string(forKey: forKey.rawValue)
    }
    
    func set(_ value: String?, forKey: UserSessionKey) {
        if let value = value, !value.isEmpty {
            keychain.set(value, forKey: forKey.rawValue)
        } else {
            _ = keychain.removeObject(forKey: forKey.rawValue)
        }
    }
    
    func removeObject(forKey: UserSessionKey) {
        keychain.removeObject(forKey: forKey.rawValue)
    }
    
    func bool(forKey: UserSessionKey) -> Bool {
        if let stringValue = keychain.string(forKey: forKey.rawValue) {
            return Bool(stringValue) ?? false
        }
        return false
    }
    
    func set(_ value: Bool, forKey: UserSessionKey) {
        keychain.set(String(value), forKey: forKey.rawValue)
    }
    
    func double(forKey: UserSessionKey) -> Double {
        if let stringValue = keychain.string(forKey: forKey.rawValue) {
            return Double(stringValue) ?? 0
        }
        return 0
    }
    
    func set(_ value: Double, forKey: UserSessionKey) {
        keychain.set(String(value), forKey: forKey.rawValue)
    }
    
    func data(forKey: UserSessionKey) -> Data? {
        keychain.data(forKey: forKey.rawValue)
    }
    
    func set(_ value: Data?, forKey: UserSessionKey) {
        if let value = value {
            keychain.set(value, forKey: forKey.rawValue)
        } else {
            _ = keychain.removeObject(forKey: forKey.rawValue)
        }
    }
    
    func removeObject(forKey: UserSessionKey) -> Bool {
        keychain.removeObject(forKey: forKey.rawValue)
    }
    
    // MARK: - HIBP API Key (Optional Convenience Methods)
    
    func saveHIBPAPIKey() {
        let key = Constants.kHBIPKey
        set(key, forKey: .hibpApiKey)
    }
    
    func getHIBPAPIKey() -> String? {
        string(forKey: .hibpApiKey)
    }
    
    func deleteHIBPAPIKey() -> Bool {
        removeObject(forKey: .hibpApiKey)
    }
        
    // MARK: - Save Password Item
    
      func savePasswordItem(_ item: PasswordItem) -> Bool {
          let key = "passwordItem-\(item.domain.lowercased())"
          do {
              let data = try JSONEncoder().encode(item)
              keychain.set(data, forKey: key)
              return true
          } catch {
              print("Failed to encode password item: \(error)")
              return false
          }
      }
      
      // MARK: - Retrieve Password Item by Domain
    
      func getPasswordItem(forDomain domain: String) -> PasswordItem? {
          let key = "passwordItem-\(domain.lowercased())"
          guard let data = keychain.data(forKey: key) else { return nil }
          do {
              return try JSONDecoder().decode(PasswordItem.self, from: data)
          } catch {
              print("Failed to decode password item: \(error)")
              return nil
          }
      }

      // MARK: - Delete Password Item by Domain
    
      func deletePasswordItem(forDomain domain: String) -> Bool {
          let key = "passwordItem-\(domain.lowercased())"
          return keychain.removeObject(forKey: key)
      }

      // MARK: - Retrieve All Password Items
    
      func getAllPasswordItems() -> [PasswordItem] {
          var items: [PasswordItem] = []
          
          for key in keychain.allKeys().filter({ $0.starts(with: "passwordItem-") }) {
              if let data = keychain.data(forKey: key) {
                  do {
                      let item = try JSONDecoder().decode(PasswordItem.self, from: data)
                      items.append(item)
                  } catch {
                      print("Failed to decode password item for key \(key): \(error)")
                  }
              }
          }
          
          return items
      }

      // MARK: - Delete All Passwords
    
      func deleteAllPasswordItems() {
          for key in keychain.allKeys().filter({ $0.starts(with: "passwordItem-") }) {
              keychain.removeObject(forKey: key)
          }
      }
    
}

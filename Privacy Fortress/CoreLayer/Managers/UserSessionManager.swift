//
//  UserSessionManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation

class UserSessionManager {
    
    static let shared = UserSessionManager()
    
    private init() {
        // Private initializer to prevent multiple instances
    }
        
    var isLongTimeNotScanned: Bool {
        guard let lastScanTimestamp = lastScanTimestamp else {
            return false 
        }
        return Date().timeIntervalSince(lastScanTimestamp) > 60 * 60 * 24 
    }
    
    var lastScanTimestamp: Date? {
        get {
            if let timestamp = UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.kLastScanTimestamp) as? TimeInterval {
                return Date(timeIntervalSince1970: timestamp)
            }
            return nil
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue.timeIntervalSince1970, forKey: Constants.UserDefaultsKeys.kLastScanTimestamp)
            } else {
                UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.kLastScanTimestamp)
            }
        }
    }
        
    var findMyEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.kFindMyEnabled)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsKeys.kFindMyEnabled)
        }
    }
    
    var dataBreachesFound: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.kDataBreachesFound)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsKeys.kDataBreachesFound)
        }
    }
    
    var isAnyPasswordsSavedToSafeStorage: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.kIsAnyPasswordsSavedToSafeStorage)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsKeys.kIsAnyPasswordsSavedToSafeStorage)
        }
    }
    
    var isMediaSafe: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.kIsMediaSafe)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsKeys.kIsMediaSafe)
        }
    }
    
    var isDeviceLockEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.kIsDeviceLockEnabled)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsKeys.kIsDeviceLockEnabled)
        }
    }
    
    var isDeviceVersionLowerThanRequired: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.isDeviceVersionLowerThanRequired)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsKeys.isDeviceVersionLowerThanRequired)
        }
    }
    
    var isMaliciousSitesProtectionEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.kIsMaliciousSitesProtectionEnabled)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsKeys.kIsMaliciousSitesProtectionEnabled)
        }
    }
    
    var isSecureNetwork: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.kIsSecureNetwork)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsKeys.kIsSecureNetwork)
        }
    }
    
    var issuesArray: [Bool] {
        return [findMyEnabled, !dataBreachesFound, isAnyPasswordsSavedToSafeStorage, isMediaSafe, isDeviceLockEnabled, !isDeviceVersionLowerThanRequired, isMaliciousSitesProtectionEnabled, isSecureNetwork]
    }
    
    public func updateLastScanDate() {
        UserSessionManager.shared.lastScanTimestamp = Date()
    }
}

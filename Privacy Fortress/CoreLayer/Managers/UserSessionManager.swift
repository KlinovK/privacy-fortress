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
    
    // MARK: - Update App Configuration
    
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
    
    var isDeviceVersionLowerThan13: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.kIsDeviceVersionLowerThan13)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsKeys.kIsDeviceVersionLowerThan13)
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
        return [findMyEnabled, !dataBreachesFound, isAnyPasswordsSavedToSafeStorage, isMediaSafe, isDeviceLockEnabled, !isDeviceVersionLowerThan13, isMaliciousSitesProtectionEnabled, isSecureNetwork]
    }
}

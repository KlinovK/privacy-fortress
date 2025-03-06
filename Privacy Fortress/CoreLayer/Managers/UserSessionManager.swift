//
//  UserSessionManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation

final class UserSessionManager {
    static let shared = UserSessionManager()
    
    private let userDefaults: Storage
    private let keychain: Storage
    
    private enum Constants {
        static let longTimeNotScannedThreshold: TimeInterval = 60 * 60 * 24 * 30
    }
    
    private init(userDefaults: Storage = UserDefaults.standard, keychain: Storage = KeychainWrapperManager.shared) {
        self.userDefaults = userDefaults
        self.keychain = keychain
    }
    
    func getOrCreateRandomUserID() -> String {
        if let existingUserID = userDefaults.string(forKey: .uniqueUserID) {
            return existingUserID
        }
        let newUserID = UUID().uuidString
        userDefaults.set(newUserID, forKey: .uniqueUserID)
        return newUserID
    }
    
    var fcmToken: String? {
        get { keychain.string(forKey: .fcmToken) }
        set { keychain.set(newValue, forKey: .fcmToken) }
    }
    
    var isUserSubscribed: Bool {
        get { userDefaults.bool(forKey: .isUserSubscribed) }
        set { userDefaults.set(newValue, forKey: .isUserSubscribed) }
    }
    
    func updateSubscriptionStatus() {
        isUserSubscribed = ApphudManager.shared.hasActiveSubscription()
    }
    
    var lastScanTimestamp: Date? {
        get {
            let timestamp = userDefaults.double(forKey: .lastScanTimestamp)
            return timestamp > 0 ? Date(timeIntervalSince1970: timestamp) : nil
        }
        set {
            if let newValue = newValue {
                userDefaults.set(newValue.timeIntervalSince1970, forKey: .lastScanTimestamp)
            } else {
                userDefaults.removeObject(forKey: .lastScanTimestamp)
            }
        }
    }
    
    var isLongTimeNotScanned: Bool {
        guard let lastScanTimestamp = lastScanTimestamp else { return false }
        return Date().timeIntervalSince(lastScanTimestamp) > Constants.longTimeNotScannedThreshold
    }
    
    func updateLastScanDate() {
        lastScanTimestamp = Date()
    }
    
    var findMyEnabled: Bool {
        get { userDefaults.bool(forKey: .findMyEnabled) }
        set { userDefaults.set(newValue, forKey: .findMyEnabled) }
    }
    
    var dataBreachesFound: Bool {
        get { userDefaults.bool(forKey: .dataBreachesFound) }
        set { userDefaults.set(newValue, forKey: .dataBreachesFound) }
    }
    
    var isAnyPasswordsSavedToSafeStorage: Bool {
        get { userDefaults.bool(forKey: .isAnyPasswordsSavedToSafeStorage) }
        set { userDefaults.set(newValue, forKey: .isAnyPasswordsSavedToSafeStorage) }
    }
    
    var isMediaSafe: Bool {
        get { userDefaults.bool(forKey: .isMediaSafe) }
        set { userDefaults.set(newValue, forKey: .isMediaSafe) }
    }
    
    var isDeviceLockEnabled: Bool {
        get { userDefaults.bool(forKey: .isDeviceLockEnabled) }
        set { userDefaults.set(newValue, forKey: .isDeviceLockEnabled) }
    }
    
    var isDeviceVersionLowerThanRequired: Bool {
        get { userDefaults.bool(forKey: .isDeviceVersionLowerThanRequired) }
        set { userDefaults.set(newValue, forKey: .isDeviceVersionLowerThanRequired) }
    }
    
    var isMaliciousSitesProtectionEnabled: Bool {
        get { userDefaults.bool(forKey: .isMaliciousSitesProtectionEnabled) }
        set { userDefaults.set(newValue, forKey: .isMaliciousSitesProtectionEnabled) }
    }
    
    var isSecureNetwork: Bool {
        get { userDefaults.bool(forKey: .isSecureNetwork) }
        set { userDefaults.set(newValue, forKey: .isSecureNetwork) }
    }
    
    var issuesArray: [Bool] {
        [
            findMyEnabled,
            !dataBreachesFound,
            isAnyPasswordsSavedToSafeStorage,
            isMediaSafe,
            isDeviceLockEnabled,
            !isDeviceVersionLowerThanRequired,
            isMaliciousSitesProtectionEnabled,
            isSecureNetwork
        ]
    }
}

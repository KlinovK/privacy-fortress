//
//  UserSessionManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation

final class UserSessionManager {
    
    static let shared = UserSessionManager()
    
    private let storage: Storage
    private let keychain: KeychainStorage
    
    private enum Constants {
        static let longTimeNotScannedThreshold: TimeInterval = 60 * 60 * 24 * 30
    }
    
    private var attributionData: [AnyHashable: Any] = [:]
    private var structuredAttribution: Attribution?
    
    private init(storage: Storage = UserDefaults.standard, keychain: KeychainStorage = KeychainWrapperManager.shared) {
        self.storage = storage
        self.keychain = keychain
        loadAttributionData()
    }
    
    // MARK: - Attribution Management
    
    func saveAppsFlyerAttribution(_ data: [AnyHashable: Any]) {
        attributionData = data
        structuredAttribution = Attribution(data: data)
        saveAttributionToStorage()
    }
    
    func getAttributionData() -> [AnyHashable: Any]? {
        return attributionData.isEmpty ? nil : attributionData
    }
    
    func getStructuredAttribution() -> Attribution? {
        structuredAttribution
    }
    
    private func saveAttributionToStorage() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: attributionData, requiringSecureCoding: false)
            storage.setString(data.base64EncodedString(), forKey: .appsFlyerAttributionData)
        } catch {
            print("Failed to archive attribution data: \(error)")
        }
    }
    
    private func loadAttributionData() {
        guard let encodedData = storage.string(forKey: .appsFlyerAttributionData),
              let data = Data(base64Encoded: encodedData) else {
            return
        }
        
        do {
            let savedData = try NSKeyedUnarchiver.unarchivedObject(
                ofClasses: [NSDictionary.self, NSString.self, NSNumber.self],
                from: data
            ) as? [AnyHashable: Any]
            
            if let savedData = savedData {
                attributionData = savedData
                structuredAttribution = Attribution(data: savedData)
            }
        } catch {
            print("Failed to unarchive attribution data: \(error)")
        }
    }
    
    func clearAttributionData() {
        attributionData = [:]
        structuredAttribution = nil
        storage.removeObject(forKey: .appsFlyerAttributionData)
    }
    
    func createOriginalTransactionID(_ transactionID: String) {
        if storage.string(forKey: .kOriginalTransactionId) == nil {
            storage.setString(transactionID, forKey: .kOriginalTransactionId)
        }
    }
    
    var originalTransactionID: String? {
        storage.string(forKey: .kOriginalTransactionId)
    }
    
    var uniqueUserID: String {
        if let existingUserID = storage.string(forKey: .uniqueUserID) {
            return existingUserID
        }
        let newUserID = UUID().uuidString
        storage.setString(newUserID, forKey: .uniqueUserID)
        return newUserID
    }
    
    // MARK: - Session Properties
    
    var fcmToken: String? {
        get { keychain.string(forKey: .fcmToken) }
        set { keychain.set(newValue, forKey: .fcmToken) }
    }
    
    var isUserSubscribed: Bool {
        get { storage.bool(forKey: .isUserSubscribed) }
        set { storage.setBool(newValue, forKey: .isUserSubscribed) }
    }
    
    func updateSubscriptionStatus() {
        isUserSubscribed = ApphudManager.shared.hasActiveSubscription()
    }
    
    var lastScanTimestamp: Date? {
        get {
            let timestamp = storage.double(forKey: .lastScanTimestamp)
            return timestamp > 0 ? Date(timeIntervalSince1970: timestamp) : nil
        }
        set {
            let timestamp = newValue?.timeIntervalSince1970 ?? 0
            storage.setDouble(timestamp, forKey: .lastScanTimestamp)
        }
    }
    
    var isLongTimeNotScanned: Bool {
        guard let lastScanTimestamp = lastScanTimestamp else { return false }
        return Date().timeIntervalSince(lastScanTimestamp) > Constants.longTimeNotScannedThreshold
    }
    
    func updateLastScanDate() {
        lastScanTimestamp = Date()
    }
    
    // MARK: - Security Properties
    
    var isFindMyEnabled: Bool {
        get { storage.bool(forKey: .findMyEnabled) }
        set { storage.setBool(newValue, forKey: .findMyEnabled) }
    }
    
    var hasDataBreaches: Bool {
        get { storage.bool(forKey: .dataBreachesFound) }
        set { storage.setBool(newValue, forKey: .dataBreachesFound) }
    }
    
    var hasPasswordsInSafeStorage: Bool {
        get { storage.bool(forKey: .isAnyPasswordsSavedToSafeStorage) }
        set { storage.setBool(newValue, forKey: .isAnyPasswordsSavedToSafeStorage) }
    }
    
    var isMediaSafe: Bool {
        get { storage.bool(forKey: .isMediaSafe) }
        set { storage.setBool(newValue, forKey: .isMediaSafe) }
    }
    
    var isDeviceLockEnabled: Bool {
        get { storage.bool(forKey: .isDeviceLockEnabled) }
        set { storage.setBool(newValue, forKey: .isDeviceLockEnabled) }
    }
    
    var isDeviceVersionOutdated: Bool {
        get { storage.bool(forKey: .isDeviceVersionLowerThanRequired) }
        set { storage.setBool(newValue, forKey: .isDeviceVersionLowerThanRequired) }
    }
    
    var isMaliciousSitesProtectionEnabled: Bool {
        get { storage.bool(forKey: .isMaliciousSitesProtectionEnabled) }
        set { storage.setBool(newValue, forKey: .isMaliciousSitesProtectionEnabled) }
    }
    
    var isNetworkSecure: Bool {
        get { storage.bool(forKey: .isSecureNetwork) }
        set { storage.setBool(newValue, forKey: .isSecureNetwork) }
    }
    
    var securityIssues: [Bool] {
        [
            isFindMyEnabled,
            !hasDataBreaches,
            hasPasswordsInSafeStorage,
            isMediaSafe,
            isDeviceLockEnabled,
            !isDeviceVersionOutdated,
            isMaliciousSitesProtectionEnabled,
            isNetworkSecure
        ]
    }
    
    func handleFirstLaunch() {
        let hasLaunchedBefore = storage.bool(forKey: .hasLaunchedBefore)
        
        if !hasLaunchedBefore {
            print("🚀 First launch detected! Clearing Keychain...")
            KeychainWrapperManager.shared.clearAll()
            storage.setBool(true, forKey: .hasLaunchedBefore)
        } else {
            print("✅ App has launched before, no need to clear Keychain.")
        }
    }
}


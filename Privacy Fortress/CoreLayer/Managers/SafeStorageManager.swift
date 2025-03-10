//
//  SafeStorageManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation

protocol SafeStorageManagerProtocol {
    func checkAndSaveIsAnyPasswordsSavedToSafeStorage() async
    func checkIsMediaSafe() async
}

class SafeStorageManager: SafeStorageManagerProtocol {
    
    // MARK: - Methods
    
    public func checkAndSaveIsAnyPasswordsSavedToSafeStorage() async {
        UserSessionManager.shared.hasPasswordsInSafeStorage = KeychainWrapperManager.shared.string(forKey: UserSessionKey.passcodeKeychainKey) != nil
    }
    
    public func checkIsMediaSafe() async {
        UserSessionManager.shared.isMediaSafe = KeychainWrapperManager.shared.string(forKey: UserSessionKey.passcodeKeychainKey) != nil
    }
    
}

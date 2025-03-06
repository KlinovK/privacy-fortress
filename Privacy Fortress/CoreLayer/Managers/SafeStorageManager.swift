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
        UserSessionManager.shared.isAnyPasswordsSavedToSafeStorage = KeychainWrapperManager.shared.string(forKey: UserSessionKey.kPasscodeKeychainKey) != nil
    }
    
    public func checkIsMediaSafe() async {
        UserSessionManager.shared.isAnyPasswordsSavedToSafeStorage = KeychainWrapperManager.shared.string(forKey: UserSessionKey.kPasscodeKeychainKey) != nil
    }
    
}

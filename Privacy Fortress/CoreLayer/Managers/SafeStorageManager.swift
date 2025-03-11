//
//  SafeStorageManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation
import CoreData

protocol SafeStorageManagerProtocol {
    func checkAndSaveIsAnyPasswordsSavedToSafeStorage() async
    func checkIsMediaSafe() async
}

class SafeStorageManager: SafeStorageManagerProtocol {
    
    // MARK: - Methods
    
    public func checkAndSaveIsAnyPasswordsSavedToSafeStorage() async {
        UserSessionManager.shared.hasPasswordsInSafeStorage = KeychainWrapperManager.shared.getAllPasswordItems().count > 1
    }
    
    public func checkIsMediaSafe() async {
        UserSessionManager.shared.isMediaSafe = LocalStorageService.shared.fetchAllMediaItems().count > 1
    }
    
}

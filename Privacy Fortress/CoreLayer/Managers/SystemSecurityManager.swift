//
//  SystemSecurityManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation
import LocalAuthentication
import UIKit

protocol SystemSecurityManagerProtocol {
    func saveIsDeviceLockStatusResult() async
    func saveDeviceVersionCheckResult() async
}

class SystemSecurityManager: SystemSecurityManagerProtocol {
    
    // MARK: - Methods
    
    private func isDeviceLockEnabled() -> Bool {
        let context = LAContext()
        var error: NSError?
        
        let isSecure = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        
        if isSecure {
            print("✅ Device Lock is enabled (Passcode, Face ID, or Touch ID).")
        } else {
            print("❌ Device Lock is NOT enabled.")
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        return isSecure
    }
    
    public func saveIsDeviceLockStatusResult() async {
        UserSessionManager.shared.isDeviceLockEnabled = isDeviceLockEnabled()
    }
    
    public func saveDeviceVersionCheckResult() async {
        let iOSVersion = ProcessInfo.processInfo.operatingSystemVersion
        let isLowerThanRequired = iOSVersion.majorVersion < Constants.lowestIOSVersion
        UserSessionManager.shared.isDeviceVersionOutdated = isLowerThanRequired
        if isLowerThanRequired {
            print("✅ Device version is lower than iOS \(Constants.lowestIOSVersion)")
        } else {
            print("✅ Device version is iOS \(Constants.lowestIOSVersion) or higher.")
        }
    }
    
}

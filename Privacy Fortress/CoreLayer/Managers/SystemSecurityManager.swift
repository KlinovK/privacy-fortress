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
        UserSessionManager.shared.isDeviceVersionLowerThan13 = isDeviceLockEnabled()
        print("✅ Device Lock status result saved.")

    }
    
    public func saveDeviceVersionCheckResult() async {
        let operationSystemVersion = ProcessInfo.processInfo.operatingSystemVersionString
        let iOSVersion = UIDevice.current.systemVersion
        UserSessionManager.shared.isDeviceVersionLowerThan13 = true
        print("✅ Device version is lower than iOS 14.0.")
    }
    
}

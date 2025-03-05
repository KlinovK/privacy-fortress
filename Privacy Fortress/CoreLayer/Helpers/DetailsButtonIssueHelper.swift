//
//  DetailsButtonIssueHelper.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 03/03/25.
//

import Foundation
import SwiftUI

final class DetailsButtonIssueHelper {
    
    public static func createIssueTypeFromGeneralIssueType(generalIssueType: GeneralIssueType) -> (IssueType, IssueType) {
        switch generalIssueType {
        case .wifiSecurity:
            return (.maliciousSitesProtection, .wifiSecurityCheck)
        case .personalDataProtection:
            return (.dataBreachMonitoring, .findMy)
        case .systemSecurity:
            return (.deviceLock, .iOSVersionCheck)
        case .safeStorage:
            return (.mediaSafe, .passwordVaul)
        }
    }

    public static func returnDestination(issueType: IssueType) -> AnyView {
        switch issueType {
        case .wifiSecurityCheck:
            return AnyView(WifiSecurityCheckScreen())
        case .dataBreachMonitoring:
            return AnyView(DataBreachesCheckScreen())
        case .deviceLock:
            return AnyView(DeviceLockStatusScreen())
        case .iOSVersionCheck:
            return AnyView(IOSVersionCkeckModule())
        case .maliciousSitesProtection:
            return AnyView(MaliciousSitesProtectionScreen())
        case .findMy:
            return AnyView(FindMyScreen())
        case .mediaSafe:
            return AnyView(DataProtectionScreen(entryPoint: .mediaSafe))
        case .passwordVaul:
#warning("")
            return AnyView(PasswordVaultScreen())
//            return AnyView(DataProtectionScreen(entryPoint: .passwordVault))
        }
    }
    
    public static func getDetailsButtonIsHiddenState(issueType: GeneralIssueType) -> (Bool, Bool)  {
        switch issueType {
        case .wifiSecurity:
            
            let maliciousSitesProtectionEnabled: Bool = UserSessionManager.shared.isMaliciousSitesProtectionEnabled
            
            return (maliciousSitesProtectionEnabled, false)
        case .personalDataProtection:
            
            let isFindMyEnabled = UserSessionManager.shared.findMyEnabled
            
            return (false, isFindMyEnabled)
        case .systemSecurity:
            
            let deviceLockEnabled = UserSessionManager.shared.isDeviceLockEnabled
            let iOSVersionCheckResult: Bool = !UserSessionManager.shared.isDeviceVersionLowerThanRequired
            
            if #available(iOS 17.0, *) {
                return (false, iOSVersionCheckResult)
            } else {
                return (deviceLockEnabled, iOSVersionCheckResult)
            }
            
        case .safeStorage:
            return (false, false)
        }
    }
    
    public static func shouldPresentSubscriptionAlert(issueType: IssueType) -> Bool {
        switch issueType {
        case .maliciousSitesProtection:
            if UserSessionManager.shared.isUserSubscribed {
                return false
            } else {
                if UserSessionManager.shared.isMaliciousSitesProtectionEnabled {
                    return true
                } else {
                    return false
                }
            }
        case .wifiSecurityCheck:
            if UserSessionManager.shared.isUserSubscribed {
                return false
            } else {
                if UserSessionManager.shared.isSecureNetwork {
                    return true
                } else {
                    return false
                }
            }
        case .dataBreachMonitoring:
            if UserSessionManager.shared.isUserSubscribed {
                return false
            } else {
                return true
            }
        case .findMy:
            if UserSessionManager.shared.isUserSubscribed {
                return false
            } else {
                return false
            }
        case .deviceLock:
            return false
        case .iOSVersionCheck:
            return false
        case .mediaSafe:
            return false
        case .passwordVaul:
            return false
        }
    }
}

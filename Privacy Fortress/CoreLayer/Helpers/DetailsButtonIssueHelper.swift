//
//  DetailsButtonIssueHelper.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 03/03/25.
//

import Foundation
import SwiftUI
import CoreData

final class DetailsButtonIssueHelper {
    
    /// Maps a `GeneralIssueType` to two specific `IssueType` cases.
    
    public static func createIssueTypeFromGeneralIssueType(generalIssueType: GeneralIssueType) -> (IssueType, IssueType) {
        switch generalIssueType {
        case .wifiSecurity:
            return (.maliciousSitesProtection, .wifiSecurityCheck)
        case .personalDataProtection:
            return (.dataBreachMonitoring, .findMy)
        case .systemSecurity:
            return (.deviceLock, .iOSVersionCheck)
        case .safeStorage:
            return (.mediaSafe, .passwordVault)
        }
    }
    
    /// Returns the destination `View` for a given `IssueType`.
    
    public static func returnDestination(issueType: IssueType) -> AnyView {
        switch issueType {
        case .wifiSecurityCheck:
            AnyView(WifiSecurityCheckScreen())
        case .dataBreachMonitoring:
            AnyView(DataBreachesCheckScreen())
        case .deviceLock:
            AnyView(DeviceLockStatusScreen())
        case .iOSVersionCheck:
            AnyView(IOSVersionCkeckModule())
        case .maliciousSitesProtection:
            AnyView(MaliciousSitesProtectionScreen())
        case .findMy:
            AnyView(FindMyScreen())
        case .mediaSafe:
            AnyView(DataProtectionScreen(entryPoint: .mediaSafe))
        case .passwordVault:
            AnyView(DataProtectionScreen(entryPoint: .passwordVault))
        }
    }
    
    /// Determines whether the details button should be hidden for a given `GeneralIssueType`.
    
    public static func getDetailsButtonIsHiddenState(issueType: GeneralIssueType) -> (Bool, Bool) {
        switch issueType {
        case .wifiSecurity:
            return (UserSessionManager.shared.isMaliciousSitesProtectionEnabled, false)
            
        case .personalDataProtection:
            return (false, UserSessionManager.shared.isFindMyEnabled)
            
        case .systemSecurity:
            let isDeviceLockEnabled = UserSessionManager.shared.isDeviceLockEnabled
            let isIOSVersionUpdated = !UserSessionManager.shared.isDeviceVersionOutdated
            
            if #available(iOS 17.0, *) {
                return (false, isIOSVersionUpdated)
            } else {
                return (isDeviceLockEnabled, isIOSVersionUpdated)
            }
            
        case .safeStorage:
            return (false, false)
        }
    }
    
    /// Determines whether a subscription alert should be presented for a given `IssueType`.
    
    public static func shouldPresentSubscriptionAlert(issueType: IssueType) -> Bool {
        guard !UserSessionManager.shared.isUserSubscribed else { return false }
        switch issueType {
        case .maliciousSitesProtection:
            return UserSessionManager.shared.isMaliciousSitesProtectionEnabled
        case .wifiSecurityCheck:
            return UserSessionManager.shared.isNetworkSecure
        case .dataBreachMonitoring:
            return true
        default:
            return false
        }
    }
}

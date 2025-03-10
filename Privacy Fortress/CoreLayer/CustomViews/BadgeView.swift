//
//  BadgeView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct BadgeView: View {
    
    let issueType: IssueType
    let badgeType: BadgeType
    
    var body: some View {
        badgeContent
            .background(RoundedRectangle(cornerRadius: 24).fill(backgroundColor))
    }
    
    private var badgeContent: some View {
        HStack {
            Text(badgeText)
                .font(.custom(FontsManager.SFSemibold.font, size: 12))
                .foregroundColor(.white)
                .fixedSize()
            
            if badgeType == .results {
                Image(badgeImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
    }
    
    /// Determines the background color based on the issue type and session status
    
    private var backgroundColor: Color {
        let session = UserSessionManager.shared
        switch issueType {
        case .maliciousSitesProtection: return session.isMaliciousSitesProtectionEnabled ? .active : .attention
        case .wifiSecurityCheck: return session.isNetworkSecure ? .active : .attention
        case .dataBreachMonitoring: return session.hasDataBreaches ? .attention : .active
        case .findMy: return session.isFindMyEnabled ? .active : .attention
        case .deviceLock: return session.isDeviceLockEnabled ? .active : .attention
        case .iOSVersionCheck: return session.isDeviceVersionOutdated ? .attention : .active
        case .mediaSafe: return session.isMediaSafe ? .active : .attention
        case .passwordVault: return session.hasPasswordsInSafeStorage ? .active : .attention
        }
    }
    
    /// Returns the appropriate badge text based on issue type and badge type
    
    private var badgeText: String {
        let session = UserSessionManager.shared
        let mainTexts: [IssueType: String] = [
            .maliciousSitesProtection: session.isMaliciousSitesProtectionEnabled ? "Sites blocked" : "Needs check",
            .wifiSecurityCheck: session.isNetworkSecure ? "Wi-Fi is secure" : "Needs check",
            .dataBreachMonitoring: session.hasDataBreaches ? "Needs check" : "No data breach detected",
            .findMy: session.isFindMyEnabled ? "iPhone is enabled" : "Needs check",
            .deviceLock: session.isDeviceLockEnabled ? "Device lock is enabled" : "Needs check",
            .iOSVersionCheck: session.isDeviceVersionOutdated ? "Needs check" : "iOS is up to date",
            .mediaSafe: session.isMediaSafe ? "Files are secure" : "Needs check",
            .passwordVault: session.hasPasswordsInSafeStorage ? "Password is secured" : "Needs check"
        ]
        
        let resultsTexts: [IssueType: String] = [
            .maliciousSitesProtection: session.isMaliciousSitesProtectionEnabled ? "Sites blocked" : "Protection is off",
            .wifiSecurityCheck: session.isNetworkSecure ? "Wi-Fi is secure" : "Insecure Wi-Fi",
            .dataBreachMonitoring: session.hasDataBreaches ? "Data breach detected" : "No breaches detected",
            .findMy: session.isFindMyEnabled ? "iPhone is enabled" : "iPhone disabled",
            .deviceLock: session.isDeviceLockEnabled ? "Device lock is enabled" : "Your data is at risk",
            .iOSVersionCheck: session.isDeviceVersionOutdated ? "iOS is outdated" : "iOS is up to date",
            .mediaSafe: session.isMediaSafe ? "Files are secure" : "Files are not secure",
            .passwordVault: session.hasPasswordsInSafeStorage ? "Password is secured" : "Password is unprotected"
        ]
        
        return badgeType == .main ? mainTexts[issueType] ?? "Unknown" : resultsTexts[issueType] ?? "Unknown"
    }
    
    /// Returns the correct badge image
    
    private var badgeImage: String {
        let icons: [IssueType: String] = [
            .maliciousSitesProtection: IconsManager.icSitesBlocked.image,
            .wifiSecurityCheck: IconsManager.icWifiIsSecure.image,
            .dataBreachMonitoring: IconsManager.icDataBreaches.image,
            .findMy: IconsManager.icFindMy.image,
            .deviceLock: IconsManager.icDeviceLock.image,
            .iOSVersionCheck: IconsManager.icIosUpToDate.image,
            .mediaSafe: IconsManager.icFilesSecure.image,
            .passwordVault: IconsManager.icPasswordSecure.image
        ]
        return icons[issueType] ?? ""
    }
}



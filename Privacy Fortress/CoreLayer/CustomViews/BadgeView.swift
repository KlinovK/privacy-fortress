//
//  BadgeView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct BadgeView: View {
    
    let issueType: IssueType
    
    var body: some View {
        fillBadgeForIssueType()
            .background(RoundedRectangle(cornerRadius: 24).fill(getBackgroundColor()))
    }
    
    private func fillBadgeForIssueType() -> some View {
        HStack {
            Text(getBadgeText())
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.white)
                .fixedSize()
            Image(getBadgeImage())
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.yellow)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
    }

    private func getBackgroundColor() -> Color {
        switch issueType {
        case .maliciousSitesProtection:
            return UserSessionManager.shared.isMaliciousSitesProtectionEnabled ? ColorManager.buttonActiveColor.color : ColorManager.protectionIsOffColor.color
        case .wifiSecurityCheck:
            return UserSessionManager.shared.isSecureNetwork ? ColorManager.buttonActiveColor.color : ColorManager.protectionIsOffColor.color
        case .dataBreachMonitoring:
            return UserSessionManager.shared.dataBreachesFound ? ColorManager.protectionIsOffColor.color :  ColorManager.buttonActiveColor.color
        case .findMy:
            return UserSessionManager.shared.findMyEnabled ? ColorManager.buttonActiveColor.color : ColorManager.protectionIsOffColor.color
        case .deviceLock:
            return UserSessionManager.shared.isDeviceLockEnabled ? ColorManager.buttonActiveColor.color : ColorManager.protectionIsOffColor.color
        case .iOSVersionCheck:
            return UserSessionManager.shared.isDeviceVersionLowerThan13 ? ColorManager.protectionIsOffColor.color : ColorManager.buttonActiveColor.color
        case .mediaSafe:
            return UserSessionManager.shared.isMediaSafe ? ColorManager.buttonActiveColor.color : ColorManager.protectionIsOffColor.color
        case .passwordVaul:
            return UserSessionManager.shared.isAnyPasswordsSavedToSafeStorage ? ColorManager.buttonActiveColor.color : ColorManager.protectionIsOffColor.color
        }
    }

    private func getBadgeText() -> String {
        switch issueType {
        case .maliciousSitesProtection:
            return UserSessionManager.shared.isMaliciousSitesProtectionEnabled ? "Sites blocked" : "Protection is off"
        case .wifiSecurityCheck:
            return UserSessionManager.shared.isSecureNetwork ? "Wi-Fi is secure" : "Insecure Wi-Fi"
        case .dataBreachMonitoring:
            return UserSessionManager.shared.dataBreachesFound ? "Data breach detected" : "No breaches detected"
        case .findMy:
            return UserSessionManager.shared.findMyEnabled ? "iPhone is enabled" : "iPhone disabled"
        case .deviceLock:
            return UserSessionManager.shared.isDeviceLockEnabled ? "Device lock is enabled" : "Your data at risk"
        case .iOSVersionCheck:
            return UserSessionManager.shared.isDeviceVersionLowerThan13 ? "iOS is outdated" : "iOS is up to date"
        case .mediaSafe:
            return UserSessionManager.shared.isMediaSafe ? "Files are securely" : "Files are not secure"
        case .passwordVaul:
            return UserSessionManager.shared.isAnyPasswordsSavedToSafeStorage ? "Password  is secured" : "Password is unprotected"
        }
    }

    private func getBadgeImage() -> String {
        switch issueType {
        case .maliciousSitesProtection:
            return IconsManager.icSitesBlocked.image
        case .wifiSecurityCheck:
            return IconsManager.icWifiIsSecure.image
        case .dataBreachMonitoring:
            return IconsManager.icDataBreaches.image
        case .findMy:
            return IconsManager.icFindMy.image
        case .deviceLock:
            return IconsManager.icDeviceLock.image
        case .iOSVersionCheck:
            return IconsManager.icIosUpToDate.image
        case .mediaSafe:
            return IconsManager.icFilesSecure.image
        case .passwordVaul:
            return IconsManager.icPasswordSecure.image
        }
    }
}


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
        fillBadgeForIssueType()
            .background(RoundedRectangle(cornerRadius: 24).fill(getBackgroundColor()))
    }
    
    private func fillBadgeForIssueType() -> some View {
        HStack {
            Text(getBadgeText())
                .font(.custom(FontsManager.SFSemibold.font, size: 12))
                .foregroundColor(Color.white)
                .fixedSize()
            
            switch badgeType {
            case .main:
                EmptyView()
            case .results:
                Image(getBadgeImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
    }

    private func getBackgroundColor() -> Color {
        switch issueType {
        case .maliciousSitesProtection:
            return UserSessionManager.shared.isMaliciousSitesProtectionEnabled ? ColorManager.buttonActiveColor.color : ColorManager.attentionTextColor.color
        case .wifiSecurityCheck:
            return UserSessionManager.shared.isSecureNetwork ? ColorManager.buttonActiveColor.color : ColorManager.attentionTextColor.color
        case .dataBreachMonitoring:
            return UserSessionManager.shared.dataBreachesFound ? ColorManager.attentionTextColor.color :  ColorManager.buttonActiveColor.color
        case .findMy:
            return UserSessionManager.shared.findMyEnabled ? ColorManager.buttonActiveColor.color : ColorManager.attentionTextColor.color
        case .deviceLock:
            return UserSessionManager.shared.isDeviceLockEnabled ? ColorManager.buttonActiveColor.color : ColorManager.attentionTextColor.color
        case .iOSVersionCheck:
            return UserSessionManager.shared.isDeviceVersionLowerThanRequired ? ColorManager.attentionTextColor.color : ColorManager.buttonActiveColor.color
        case .mediaSafe:
            return UserSessionManager.shared.isMediaSafe ? ColorManager.buttonActiveColor.color : ColorManager.attentionTextColor.color
        case .passwordVaul:
            return UserSessionManager.shared.isAnyPasswordsSavedToSafeStorage ? ColorManager.buttonActiveColor.color : ColorManager.attentionTextColor.color
        }
    }

    private func getBadgeText() -> String {
        switch badgeType {
        case .main:
            switch issueType {
            case .maliciousSitesProtection:
                return UserSessionManager.shared.isMaliciousSitesProtectionEnabled ? "Sites blocked" : "Needs check"
            case .wifiSecurityCheck:
                return UserSessionManager.shared.isSecureNetwork ? "Wi-Fi is secure" : "Needs check"
            case .dataBreachMonitoring:
                return UserSessionManager.shared.dataBreachesFound ? "Needs check" : "No data breach detected"
            case .findMy:
                return UserSessionManager.shared.findMyEnabled ? "iPhone is enabled" : "Needs check"
            case .deviceLock:
                return UserSessionManager.shared.isDeviceLockEnabled ? "Device lock is enabled" : "Needs check"
            case .iOSVersionCheck:
                return UserSessionManager.shared.isDeviceVersionLowerThanRequired ? "Needs check" : "iOS is up to date"
            case .mediaSafe:
                return UserSessionManager.shared.isMediaSafe ? "Files are securely" : "Needs check"
            case .passwordVaul:
                return UserSessionManager.shared.isAnyPasswordsSavedToSafeStorage ? "Password  is secured" : "Needs check"
            }
        case .results:
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
                return UserSessionManager.shared.isDeviceVersionLowerThanRequired ? "iOS is outdated" : "iOS is up to date"
            case .mediaSafe:
                return UserSessionManager.shared.isMediaSafe ? "Files are securely" : "Files are not secure"
            case .passwordVaul:
                return UserSessionManager.shared.isAnyPasswordsSavedToSafeStorage ? "Password  is secured" : "Password is unprotected"
            }
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


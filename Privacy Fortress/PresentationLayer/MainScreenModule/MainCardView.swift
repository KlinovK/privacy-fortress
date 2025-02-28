//
//  MainCardView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 24/02/25.
//

import SwiftUI

struct MainCardView: View {
    
    let issueType: GeneralIssueType
    
    @State private var showAlert = false
    @State private var shouldNavigate = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            Color.white
                .cornerRadius(16)
            
            createCellWithType()

        }
        .frame(maxWidth: .infinity, maxHeight: 290)
    }
    
    private func createCellWithType() -> some View {
        VStack {
            HStack(spacing: 5.5) {
                Image(getHeaderImage(issueType: issueType))
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color.black)
                Text(getHeaderTitle(issueType: issueType))
                    .foregroundColor(ColorManager.textDefaultColor.color)
                    .font(.custom(FontsManager.SFbold.font, size: 18))
                    .underline()
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack {
                HStack {
                    Text(getFirstRowTitleAndSubtitle(issueType: issueType).0)
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFSemibold.font, size: 16))
                    
                    BadgeView(issueType: getBadgeType(issueType: issueType).0, badgeType: .main)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(getFirstRowTitleAndSubtitle(issueType: issueType).1)
                    .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                    .font(.custom(FontsManager.SFlight.font, size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                NavigationLink(destination: returnDestination(issueType: issueType).0) {
                    Text("Details")
                        .foregroundColor(ColorManager.buttonActiveColor.color)
                        .underline()
                        .font(.custom(FontsManager.SFRegular.font, size: 14))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .hidden(getDetailsButtonIsHiddenState(issueType: issueType).0)
            }
            
            Separator()
            
            VStack {
                HStack {
                    Text(getSecondRowTitleAndSubtitle(issueType: issueType).0)
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFSemibold.font, size: 16))
                    BadgeView(issueType: getBadgeType(issueType: issueType).1, badgeType: .main)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text(getSecondRowTitleAndSubtitle(issueType: issueType).1)
                    .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                    .font(.custom(FontsManager.SFlight.font, size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                NavigationLink(destination: returnDestination(issueType: issueType).1) {
                    Text("Details")
                        .foregroundColor(ColorManager.buttonActiveColor.color)
                        .underline()
                        .font(.custom(FontsManager.SFRegular.font, size: 14))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .hidden(getDetailsButtonIsHiddenState(issueType: issueType).1)
            }
        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
    }
    
    private func getHeaderTitle(issueType: GeneralIssueType) -> String {
        switch issueType {
        case .wifiSecurity:
            return "Wi-Fi Security"
        case .personalDataProtection:
            return "Personal Data Protection"
        case .systemSecurity:
            return "System Security"
        case .safeStorage:
            return "Safe Storage"
        }
    }
    
    private func getFirstRowTitleAndSubtitle(issueType: GeneralIssueType) -> (String, String) {
        switch issueType {
        case .wifiSecurity:
            return ("Malicious Sites Protection:", "Harmful websites will be blocked for your safety.")
        case .personalDataProtection:
            return ("Data Breach Monitoring:", "Detect if your personal data has been leaked from the services you use.")
        case .systemSecurity:
            return ("Device Lock:", "Ensure Device Lock is enabled to secure your device from unauthorized access.")
        case .safeStorage:
            return ("Media Safe", "Securely store your photos and videos!")
        }
    }
    
    private func getSecondRowTitleAndSubtitle(issueType: GeneralIssueType) -> (String, String) {
        switch issueType {
        case .wifiSecurity:
            return ("Wi-Fi Security Check:", "This network may expose your data to unauthorized access or attacks.")
        case .personalDataProtection:
            return ("Find My:", "Your device can be lost or stolen. Find it quickly.")
        case .systemSecurity:
            return ("iOS Version Check:", "Update your device to ensure optimal security and performance.")
        case .safeStorage:
            return ("Password Vault", "Securely store and manage your passwords!")
        }
    }
    
    private func getHeaderImage(issueType: GeneralIssueType) -> String {
        switch issueType {
        case .wifiSecurity:
            return IconsManager.icWifiSecurity.image
        case .personalDataProtection:
            return IconsManager.icPersonalDataSecurity.image
        case .systemSecurity:
            return IconsManager.icSystemSecurity.image
        case .safeStorage:
            return IconsManager.icDataBreaches.image
        }
    }
    
    private func getBadgeType(issueType: GeneralIssueType) -> (IssueType, IssueType) {
        switch issueType {
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
    
    private func returnDestination(issueType: GeneralIssueType) -> (AnyView, AnyView) {
        switch issueType {
        case .wifiSecurity:
            return (AnyView(MaliciousSitesProtectionScreen()), AnyView(WifiSecurityCheckScreen()))
        case .personalDataProtection:
            return (AnyView(DataBreachesCheckScreen()), AnyView(FindMyScreen()))
        case .systemSecurity:
            return (AnyView(DeviceLockStatusScreen()), AnyView(IOSVersionCkeckModule()))
        case .safeStorage:
            return (AnyView(DataProtectionScreen(dataProtection: .mediaSafe, correctPasscode: "", onUnlock: {})), AnyView(DataProtectionScreen(dataProtection: .passwordVault, correctPasscode: "", onUnlock: {})))
        }
    }
    
    private func getDetailsButtonIsHiddenState(issueType: GeneralIssueType) -> (Bool, Bool)  {
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
}


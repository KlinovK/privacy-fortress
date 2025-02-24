//
//  ResultCardViewView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 22/02/25.
//

import SwiftUI

struct ResultCardView: View {
        
    let generalIssueType: GeneralIssueType

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white
                .frame(height: 148)
                .cornerRadius(16)
            HStack(spacing: 5.5) {
                Image(getImageName())
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color.black)
                Text(getTitlesTuple().0)
                    .foregroundColor(ColorManager.textDefaultColor.color)
                    .font(.custom(FontsManager.SFSemibold.font, size: 18))
                    .underline()
            }
            .padding(EdgeInsets(top: 16, leading: 12, bottom: 0, trailing: 0))
            
            VStack(spacing: 12) {
                HStack {
                    Text(getTitlesTuple().1)
                        .font(.custom(FontsManager.SFlight.font, size: 14))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    Spacer()
                    BadgeView(issueType: getFirstIssueType(), badgeType: .results)
                }
                
                HStack {
                    Text(getTitlesTuple().2)
                        .font(.custom(FontsManager.SFlight.font, size: 14))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    Spacer()
                    BadgeView(issueType: getSecondIssueType(), badgeType: .results)
                }
            }
            .padding(EdgeInsets(top: 64, leading: 12, bottom: 0, trailing: 12))


        }
        .frame(maxWidth: .infinity)
        
    }
    
    private func getTitlesTuple() -> (String, String, String) {
        switch generalIssueType {
        case .wifiSecurity:
            return ("Wi-Fi Security", "Malicious Sites Protection:", "Wi-Fi Security Check:")
        case .personalDataProtection:
            return ("Personal Data Protection", "Data Breach Monitoring:", "Find My:")
        case .systemSecurity:
            return ("System Security", "Device Lock:", "iOS Version Check:")
        case .safeStorage:
            return ("Safe Storage", "Encrypted Files:", "File Sharing:")
        }
    }
    
    private func getImageName() -> String {
        switch generalIssueType {
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
    
    private func getFirstIssueType() -> IssueType {
        switch generalIssueType {
        case .wifiSecurity:
            return .maliciousSitesProtection
        case .personalDataProtection:
            return .dataBreachMonitoring
        case .systemSecurity:
            return .deviceLock
        case .safeStorage:
            return .mediaSafe
        }
    }
    
    private func getSecondIssueType() -> IssueType {
        switch generalIssueType {
        case .wifiSecurity:
            return .wifiSecurityCheck
        case .personalDataProtection:
            return .findMy
        case .systemSecurity:
            return .iOSVersionCheck
        case .safeStorage:
            return .passwordVaul
        }
    }
}


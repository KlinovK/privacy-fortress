//
//  StartCardViewView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct StartCardViewView: View {
    
    let issueType: GeneralIssueType

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            Color.white
                .frame(height: 109)
                .cornerRadius(16)

            HStack(alignment: .top) {
                Image(getIssueImageName(issueType: issueType))
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding(.top, 14)
                    .foregroundColor(ColorManager.buttonActiveColor.color)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(getIssueTitleAndSubtitle(issueType: issueType).0)
                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                        .frame(alignment: .leading)
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    Text(getIssueTitleAndSubtitle(issueType: issueType).1)
                        .font(.custom(FontsManager.SFlight.font, size: 16))
                        .frame(alignment: .leading)
                        .foregroundColor(ColorManager.textDefaultColor.color)
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 16)
        }
        
        .frame(maxWidth: .infinity)
    }
    
    private func getIssueTitleAndSubtitle(issueType: GeneralIssueType) -> (title: String, subtitle: String) {
        switch issueType {
        case .wifiSecurity:
            return ("Wi-Fi Security", "Ensure your Wi-Fi connection is safe and secure")
        case .personalDataProtection:
            return ("Personal Data Protection", "Monitor and protect your personal information")
        case .systemSecurity:
            return ("System Security", "Check your device settings for optimal security")
        case .safeStorage:
            return ("Safe Storage", "Securely store your media and passwords.")
        }
    }
    
    private func getIssueImageName(issueType: GeneralIssueType) -> String {
        switch issueType {
        case .wifiSecurity:
            return IconsManager.icWifiSecurity.image
        case .personalDataProtection:
            return IconsManager.icPersonalDataSecurity.image
        case .systemSecurity:
            return IconsManager.icSystemSecurity.image
        case .safeStorage:
            return IconsManager.icPersonalStorage.image
        }
    }
}

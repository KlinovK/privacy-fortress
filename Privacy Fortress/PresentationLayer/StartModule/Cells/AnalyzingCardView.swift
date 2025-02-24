//
//  AnalyzingCardView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct AnalyzingCardView: View {
    
    let issueType: GeneralIssueType
    var isNoIssuesState: Bool = false
    let progress: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.white
                .frame(height: 77)
                .cornerRadius(16)

            Image(getIssueImageName(issueType: issueType))
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .padding()
                .foregroundColor(
                    isNoIssuesState ?
                    ColorManager.buttonActiveColor.color :
                    (progress < 1 ? Color.gray : ColorManager.buttonActiveColor.color)
                )
              
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text(getIssueTitleAndSubtitle(issueType: issueType).0)
                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    if !isNoIssuesState {
                        HorizontalProgressView(progress: progress)
                            .frame(alignment: .leading)
                    }
                }
                
                Spacer()
                
                ZStack {
                    if isNoIssuesState {
                        Image(IconsManager.icCheckmark.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    } else {
                        if progress < 1 {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        } else {
                            Image(IconsManager.icCheckmark.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 14, leading: 64, bottom: 14, trailing: 16))
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

//
//  ResultsScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct ResultsScreen: View {
        
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    updatedHeaderView()
                    NavigationLink(destination: PaywallScreen()) {
                        Text("Resolve All Issues")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .font(.custom(FontsManager.SFSemibold.font, size: 20))
                            .cornerRadius(10)
                    }
                }
                .padding(.top, Constants.isIPad ? 88 : 21)
                .padding(.horizontal, Constants.isIPad ? 190 : 16)
                .frame(height: geometry.size.height)
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)            
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private func setupResultsCardViews() -> some View {
        VStack(spacing: 12) {
            ResultCardViewView(title: "Wi-Fi Security", firstIssueTitle: "Malicious Sites Protection:", secondIssueTitle: "Wi-Fi Security Check:", imageName: IconsManager.icWifiSecurity.image, firstIssueType: .maliciousSitesProtection, secondIssueType: .wifiSecurityCheck)
            ResultCardViewView(title: "Personal Data Protection", firstIssueTitle: "Data Breach Monitoring:", secondIssueTitle: "Find My:", imageName: IconsManager.icPersonalDataSecurity.image, firstIssueType: .dataBreachMonitoring, secondIssueType: .findMy)
            ResultCardViewView(title: "System Security", firstIssueTitle: "Device Lock:", secondIssueTitle: "iOS Version Check:", imageName: IconsManager.icSystemSecurity.image, firstIssueType: .deviceLock, secondIssueType: .iOSVersionCheck)
            ResultCardViewView(title: "Safe Storage", firstIssueTitle: "Media Safe:", secondIssueTitle: "Password Vault:", imageName: IconsManager.icPersonalStorage.image, firstIssueType: .mediaSafe, secondIssueType: .passwordVaul)
        }
        .padding(.top, 16)
    }
    
    private func updatedHeaderView() -> some View {
        VStack(spacing: 12) {
                Image(UserSessionManager.shared.issuesArray.contains(false) ? IconsManager.icIssuesFound.image : IconsManager.icSssuesNotFound.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 116, height: 116)
                Text(UserSessionManager.shared.issuesArray.contains(false) ? "\(UserSessionManager.shared.issuesArray.filter { $0 == false }.count) issues found" : "Issues not found")
                .font(.custom(FontsManager.SFbold.font, size: 24))
            
                .foregroundColor(UserSessionManager.shared.issuesArray.contains(false) ? ColorManager.attentionTextColor.color : ColorManager.buttonActiveColor.color)
            
                Text(UserSessionManager.shared.issuesArray.contains(false) ? "Resolve issues to optimize your device's security." : "Your device is fully protected and secure!")
                .font(.custom(FontsManager.SFRegular.font, size: 16))
                .foregroundColor(ColorManager.textDefaultColor.color)
            
                setupResultsCardViews()
        }
    }
}

#Preview {
    ResultsScreen()
}


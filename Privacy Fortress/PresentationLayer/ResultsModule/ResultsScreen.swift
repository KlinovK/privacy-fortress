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
                    resolveAllIssuesButton()
                }
                .padding(.bottom, 20)
                .padding(.top, Constants.isIPad ? 88 : 21)
                .padding(.horizontal, Constants.isIPad ? 190 : 16)
                .frame(height: geometry.size.height)
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)            
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private func resolveAllIssuesButton() -> some View {
        NavigationLink(destination: createDestinationView()) {
            Text("Resolve All Issues")
                .padding()
                .frame(maxWidth: .infinity)
                .background(ColorManager.buttonActiveColor.color)
                .foregroundColor(.white)
                .font(.custom(FontsManager.SFSemibold.font, size: 20))
                .cornerRadius(10)
        }
    }
    
    private func setupResultsCardViews() -> some View {
        VStack(spacing: 12) {
            ResultCardView(generalIssueType: .wifiSecurity)
            ResultCardView(generalIssueType: .personalDataProtection)
            ResultCardView(generalIssueType: .systemSecurity)
            ResultCardView(generalIssueType: .safeStorage)
        }
        .padding(.top, 16)
    }
    
    private func updatedHeaderView() -> some View {
        VStack(spacing: 12) {
            Image(UserSessionManager.shared.securityIssues.contains(false) ? IconsManager.icIssuesFound.image : IconsManager.icSssuesNotFound.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 116, height: 116)
                Text(UserSessionManager.shared.securityIssues.contains(false) ? "\(UserSessionManager.shared.securityIssues.filter { $0 == false }.count) issues found" : "Issues not found")
                .font(.custom(FontsManager.SFbold.font, size: 24))
            
                .foregroundColor(UserSessionManager.shared.securityIssues.contains(false) ? ColorManager.attentionTextColor.color : ColorManager.buttonActiveColor.color)
            
                Text(UserSessionManager.shared.securityIssues.contains(false) ? "Resolve issues to optimize your device's security." : "Your device is fully protected and secure!")
                .font(.custom(FontsManager.SFRegular.font, size: 16))
                .foregroundColor(ColorManager.textDefaultColor.color)
            
                setupResultsCardViews()
        }
    }
    
    public func createDestinationView() -> some View {
        if UserSessionManager.shared.isUserSubscribed {
            return AnyView(MainScreen())
        } else {
            return AnyView(PaywallScreen())
        }
    }
}

#Preview {
    ResultsScreen()
}


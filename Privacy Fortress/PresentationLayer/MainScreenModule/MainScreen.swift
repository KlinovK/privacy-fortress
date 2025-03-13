//
//  MainScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var shouldNavigateToPaywall = false
    @State private var issueType: IssueType?
    @State private var shouldNavigateToDestination = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    updatedHeaderView()
                    
                    activateProtectionButton()
                    
                    navigationLinks
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
    
    private func activateProtectionButton() -> some View {
        NavigationLink(destination: PaywallScreen()) {
            Text("Activate Your Full Protection Now!")
                .padding()
                .frame(maxWidth: .infinity)
                .background(ColorManager.buttonActiveColor.color)
                .foregroundColor(.white)
                .font(.custom(FontsManager.SFSemibold.font, size: 20))
                .cornerRadius(10)
        }
    }
    
    private func setupResultsCardViews() -> some View {
        let issueTypes: [GeneralIssueType] = [
            .wifiSecurity, .personalDataProtection, .systemSecurity, .safeStorage
        ]
        
        return VStack(spacing: 12) {
            ForEach(issueTypes, id: \.self) { type in
                MainCardView(issueType: type, detailsButtonWasPressed: navigateTo)
            }
        }
        .padding(.top, 0)
    }
    
    private func updatedHeaderView() -> some View {
        VStack(spacing: 0) {
            ZStack {
                Image(IconsManager.icAppLogoStartScreen.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 115, height: 138)
                    .padding(.bottom, 19)
                VStack {
                    HStack {
                        manageSubscriptionsButton()
                        Spacer()
                        settingsButton()
                    }
                    .padding()
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Check Issues to Improve \n Your Device Security and Stay Protected")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 16)
                .font(.custom(FontsManager.SFSemibold.font, size: 20))
                .foregroundColor(ColorManager.textDefaultColor.color)
            setupResultsCardViews()
        }
    }
    
    private func settingsButton() -> some View {
        NavigationLink(destination: SettingsScreen()) {
            Image(IconsManager.icSettings.image)
                .frame(width: 44, height: 44)
                .background(Color.clear)
                .cornerRadius(10)
        }
    }
    
    private func manageSubscriptionsButton() -> some View {
        Button(action: {
            openManageSubscriptions()
        }) {
            Image(systemName: "dollarsign.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
        }
    }
    
    private func navigateTo(issueType: IssueType) {
        self.issueType = issueType
        if DetailsButtonIssueHelper.shouldPresentSubscriptionAlert(issueType: issueType) {
            shouldNavigateToPaywall = true
        } else {
            shouldNavigateToDestination = true
        }
    }
    
    private var navigationLinks: some View {
        Group {
            NavigationLink(destination: PaywallScreen(), isActive: $shouldNavigateToPaywall) {
                EmptyView()
            }
            .hidden()
            
            NavigationLink(destination: DetailsButtonIssueHelper.returnDestination(issueType: issueType ?? .maliciousSitesProtection),
                           isActive: $shouldNavigateToDestination) {
                EmptyView()
            }
            .hidden()
        }
    }
    
    private func openManageSubscriptions() {
        Task {
            do {
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    try await ApphudManager.shared.showManageSubscriptions(in: scene)
                }
            } catch {
                print("Failed to open subscription management: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    MainScreen()
}

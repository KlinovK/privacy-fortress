//
//  MainScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var showSubscriptionAlert = false
    @State private var shouldNavigateToPaywall = false
    @State private var issueType: IssueType?
    @State private var shouldNavigateToDestination = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    updatedHeaderView()
                    NavigationLink(destination: PaywallScreen()) {
                        Text("Activate Your Full Protection Now!")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(ColorManager.buttonActiveColor.color)
                            .foregroundColor(.white)
                            .font(.custom(FontsManager.SFSemibold.font, size: 20))
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(
                        destination: PaywallScreen(),
                        isActive: $shouldNavigateToPaywall
                    ) {
                        EmptyView()
                    }
                    .hidden()
            
                    NavigationLink(
                        destination: DetailsButtonIssueHelper.returnDestination(issueType: issueType ?? .maliciousSitesProtection),
                        isActive: $shouldNavigateToDestination
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }
                .padding(.top, Constants.isIPad ? 88 : 21)
                .padding(.horizontal, Constants.isIPad ? 190 : 16)
                .frame(height: geometry.size.height)
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
            .toolbar(.hidden, for: .navigationBar)
        }
        .overlay(
            SubscriptionAlertView(
                isPresented: $showSubscriptionAlert,
                onDismiss: { didSubscribe in
                    if didSubscribe {
                        shouldNavigateToPaywall = true
                    }
                }
            )
        )
    }
    
    private func setupResultsCardViews() -> some View {
        VStack(spacing: 12) {
            MainCardView(issueType: .wifiSecurity, detailsButtonWasPressed: { receivedIssueType in
                presentSubscriptionAlertIfNeeded(receivedIssueType: receivedIssueType)
            })
            MainCardView(issueType: .personalDataProtection, detailsButtonWasPressed: { receivedIssueType in
                presentSubscriptionAlertIfNeeded(receivedIssueType: receivedIssueType)
            })
            MainCardView(issueType: .systemSecurity, detailsButtonWasPressed: { receivedIssueType in
                presentSubscriptionAlertIfNeeded(receivedIssueType: receivedIssueType)
            })
            MainCardView(issueType: .safeStorage, detailsButtonWasPressed: { receivedIssueType in
                presentSubscriptionAlertIfNeeded(receivedIssueType: receivedIssueType)
            })
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
                        Spacer()
                        NavigationLink(destination: SettingsScreen()) {
                            Image(IconsManager.icSettings.image)
                                .frame(width: 44, height: 44)
                                .background(Color.clear)
                                .cornerRadius(10)
                        }
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
    
    private func presentSubscriptionAlertIfNeeded(receivedIssueType: IssueType) {
        issueType = receivedIssueType
        var shouldPresentSubscriptionAlert = DetailsButtonIssueHelper.shouldPresentSubscriptionAlert(issueType: receivedIssueType)
        if shouldPresentSubscriptionAlert {
            showSubscriptionAlert = true
        } else {
            shouldNavigateToDestination = true
        }
    }
}

#Preview {
    MainScreen()
}

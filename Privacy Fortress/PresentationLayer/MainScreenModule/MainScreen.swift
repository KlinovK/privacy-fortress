//
//  MainScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var showAlert = false
    
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
            SubscriptionAlertView(isPresented: $showAlert)
        )
    }
    
    private func setupResultsCardViews() -> some View {
        VStack(spacing: 12) {
            MainCardView(issueType: .wifiSecurity)
            MainCardView(issueType: .personalDataProtection)
            MainCardView(issueType: .systemSecurity)
            MainCardView(issueType: .safeStorage)
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
}

#Preview {
    MainScreen()
}

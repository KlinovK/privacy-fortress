//
//  SettingsScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct SettingsScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(IconsManager.icUnlockPremium.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, minHeight: 158, maxHeight: 158)
                        .padding(.bottom, 25)
                    
                    VStack(spacing: 8) {
                        returnSettingsCell(cellType: .rateUs)
                        returnSettingsCell(cellType: .shareApp)
                        returnSettingsCell(cellType: .privacyPolicy)
                        returnSettingsCell(cellType: .termsOfService)
                        returnSettingsCell(cellType: .changePassword)
                        returnSettingsCell(cellType: .subscriptions)
                    }
                }
                .padding(.top, Constants.isIPad ? 88 : 20)
                .padding(.horizontal, Constants.isIPad ? 190 : 16)
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private func returnSettingsCell(cellType: SettingsCellType) -> some View {
        HStack(spacing: 10) {
            Image(getCellImage(for: cellType))
                .frame(width: 24, height: 24)
                .padding(.leading, 20)
            Text(getCellTitle(for: cellType))
                .font(.custom(FontsManager.SFRegular.font, size: 18))
                .foregroundColor(ColorManager.textDefaultColor.color)
            Spacer()
            Image(IconsManager.icChevronRight.image)
                .frame(width: 24, height: 24)
                .padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
        .background(Color.white)
        .cornerRadius(10)
        .onTapGesture {
            switch cellType {
            case .rateUs:
                rateApp()
            case .shareApp:
                shareApp()
            case .privacyPolicy:
                openURL(Constants.privacyPolicyURLString)
            case .termsOfService:
                openURL(Constants.termsAndConditionsURLString)
            case .changePassword:
                navigateToChangePassword()
            case .subscriptions:
                navigateToSubscriptions()
            }
        }
    }
    
    private func getCellImage(for cellType: SettingsCellType) -> String {
        switch cellType {
        case .rateUs:
            return IconsManager.icRateUs.image
        case .shareApp:
            return IconsManager.icShareApp.image
        case .privacyPolicy:
            return IconsManager.icPrivacyPolicy.image
        case .termsOfService:
            return IconsManager.icTermsOfService.image
        case .changePassword:
            return IconsManager.icChangePassword.image
        case .subscriptions:
            return IconsManager.icSubscription.image
        }
    }
    
    private func getCellTitle(for cellType: SettingsCellType) -> String {
        switch cellType {
        case .rateUs:
            return "Rate Us"
        case .shareApp:
            return "Share App"
        case .privacyPolicy:
            return "Privacy Policy"
        case .termsOfService:
            return "Terms of Service"
        case .changePassword:
            return "Change Password"
        case .subscriptions:
            return "Subscription"
        }
    }
    
    private func rateApp() {
        // TODO: -
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/idYOUR_APP_ID?action=write-review") else { return }
        UIApplication.shared.open(url)
    }

    private func shareApp() {
        // TODO: -
        let appURL = "https://apps.apple.com/app/idYOUR_APP_ID"
        let activityVC = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first,
           let topVC = window.rootViewController {
            topVC.present(activityVC, animated: true)
        }
    }

    private func openURL(_ urlString: String) {
        // TODO: -
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }

    private func navigateToChangePassword() {
        // TODO: -
        // Implement navigation to the Change Password screen
    }

    private func navigateToSubscriptions() {
        // TODO: -
        // Implement navigation to the Subscriptions screen
    }
}

#Preview {
    SettingsScreen()
}

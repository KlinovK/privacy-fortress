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
                        .frame(maxWidth: .infinity, minHeight: !UserSessionManager.shared.isUserSubscribed ? 0 : 158, maxHeight: !UserSessionManager.shared.isUserSubscribed ? 0 : 158)
                        .padding(.bottom, 25)
                        .hidden(!UserSessionManager.shared.isUserSubscribed)
                    
                    VStack(spacing: 8) {
                        returnSettingsCell(cellType: .rateUs)
                        returnSettingsCell(cellType: .shareApp)
                        returnSettingsCell(cellType: .privacyPolicy)
                        returnSettingsCell(cellType: .termsOfService)
                        changePasswordView()
                    }
                }
                .padding(.top, Constants.isIPad ? 32 : 20)
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
    
    private func changePasswordView() -> some View {
        NavigationLink {
            DataProtectionScreen(entryPoint: .settings)
        } label: {
            HStack(spacing: 10) {
                Image(getCellImage(for: .changePassword))
                    .frame(width: 24, height: 24)
                    .padding(.leading, 20)
                Text(getCellTitle(for: .changePassword))
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
        }
    }
    
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
                break
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
        }
    }
    
    private func rateApp() {
        let reviewURL = "itms-apps://itunes.apple.com/app/id\(Constants.appStoreID)?action=write-review"
        guard let url = URL(string: reviewURL) else { return }
        UIApplication.shared.open(url)
    }

    private func shareApp() {
        let appURL = "https://apps.apple.com/app/id\(Constants.appStoreID)"
        let activityVC = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first,
           let topVC = window.rootViewController {
            topVC.present(activityVC, animated: true)
        }
    }

    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}

#Preview {
    SettingsScreen()
}

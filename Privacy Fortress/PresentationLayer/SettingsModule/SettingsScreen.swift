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
    
    private func returnSettingsCell(cellType: SettingsCellType) -> some View {
        HStack(spacing: 10) {
            Image(systemName: "lock.shield.fill")
                .frame(width: 24, height: 24)
                .padding(.leading, 20)
            Text(getCellTitle(for: cellType))
            Spacer()
            Image(IconsManager.icChevronRight.image)
                .frame(width: 24, height: 24)
                .padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
        .background(Color.white)
        .cornerRadius(10)
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
            return "Subscriptions"
        }
    }
}

#Preview {
    SettingsScreen()
}

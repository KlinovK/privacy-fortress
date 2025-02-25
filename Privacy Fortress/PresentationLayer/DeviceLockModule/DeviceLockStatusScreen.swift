//
//  DeviceLockStatusScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 25/02/25.
//

import SwiftUI

struct DeviceLockStatusScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var deviceLockViewState: DeviceLockViewState = UserSessionManager.shared.isDeviceLockEnabled ? .enabled : .disabled

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack() {
                    Image(getScreenImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 202, height: 230)
                        .padding(.bottom, 20)
                    Text(getScreenTitleAndColor().0)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(getScreenTitleAndColor().1)
                        .font(.custom(FontsManager.SFSemibold.font, size: 28))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 12)
                    
                    Text(getScreenSubtitle())
                        .frame(maxWidth: .infinity)
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    NavigationLink(destination: DeviceLockDetailsScreen()) {
                        Text("Details")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(ColorManager.buttonActiveColor.color)
                            .foregroundColor(.white)
                            .font(.custom(FontsManager.SFSemibold.font, size: 20))
                            .cornerRadius(10)
                    }

                }
                .padding(.top, Constants.isIPad ? 284 : 120)
                .padding(.horizontal, Constants.isIPad ? 190 : 24)
                .frame(height: geometry.size.height)
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationTitle("Please verify your identity")
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
    
    private func getScreenImage() -> String {
        switch deviceLockViewState {
        case .enabled:
            return IconsManager.icDeviceLockEnabled.image
        case .disabled:
            return IconsManager.icDeviceLockDisabled.image
        }
    }
    
    private func getScreenTitleAndColor() -> (String, Color) {
        switch deviceLockViewState {
        case .enabled:
            return ("Device Lock is enabled. \nYour device is secure.", ColorManager.buttonActiveColor.color)
        case .disabled:
            return ("Device Lock is not enabled.", ColorManager.attentionTextColor.color)
        }
    }
    
    private func getScreenSubtitle() -> AttributedString {
        var fullText: AttributedString

        switch deviceLockViewState {
        case .enabled:
            fullText = AttributedString("The Password Recovery Key helps you securely recover access to your device if you forget your passcode.")
        case .disabled:
            fullText = AttributedString("To protect your data, we recommend setting up a passcode, Face ID, or Touch ID")
        }

        if let range = fullText.range(of: "The Password Recovery Key") {
            fullText[range].font = .system(size: 18, weight: .bold)
        }
        
        if let range = fullText.range(of: "a passcode, Face ID, or Touch ID") {
            fullText[range].font = .system(size: 18, weight: .bold)
        }

        return fullText
    }
}

#Preview {
    DeviceLockStatusScreen()
}

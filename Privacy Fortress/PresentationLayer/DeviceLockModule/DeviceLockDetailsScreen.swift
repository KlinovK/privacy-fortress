//
//  DeviceLockDetailsScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 25/02/25.
//

import SwiftUI

struct DeviceLockDetailsScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var deviceLockDetailsViewState: DeviceLockDetailsViewState = .defaultTutorial
    
    init() {
        deviceLockDetailsViewState = getDeviceLockDetailsViewState()
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        if deviceLockDetailsViewState == .defaultTutorial {
                            createDefaultTutorial()
                        } else {
                            createiOS17Tutorial()
                        }
                        
                        Spacer()
                        
                        goToSettingsButton()
                    }
                    .frame(height: geometry.size.height)
                }
                .padding(.bottom, 0)
                .padding(.top, Constants.isIPad ? 24 : 16)
                .padding(.horizontal, Constants.isIPad ? 190 : 16)
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
        }
        .navigationTitle("Please verify your identity")
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
    
    private func openAppSettings() {
        guard let url = URL(string:"App-Prefs:root=General") else { return }
        UIApplication.shared.open(url)
    }
    
    private func createDefaultTutorial() -> some View {
        VStack {
            HStack() {
                Image(IconsManager.icFirst.image)
                    .frame(width: 24, height: 24)
                Text("Open \"Settings\"")                                .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 12)
            Text("On your device's home screen, find and tap the ")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(FontsManager.SFRegular.font, size: 14))
                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                .padding(.bottom, 4)
            
            HStack(spacing: 10) {
                Image(IconsManager.icSettingsSmall.image)
                    .frame(width: 24, height: 24)
                Text("Settings")
                    .font(.custom(FontsManager.SFRegular.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 16)
            
            Separator()
                .padding(.bottom, 16)
            
            HStack(spacing: 10) {
                Image(IconsManager.icSecond.image)
                    .frame(width: 24, height: 24)
                Text("Tap Face ID & Passcode or Touch ID & Passcode")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 12)
            
            Image(IconsManager.icFaceIDPasscode.image)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.bottom, 16)
            
            
            Separator()
                .padding(.bottom, 16)
            
            HStack(spacing: 10) {
                Image(IconsManager.icThird.image)
                    .frame(width: 24, height: 24)
                Text("Turn Passcode On")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 12)
            
            Text("Set Up Face ID or Touch ID (Optional)")
                .font(.custom(FontsManager.SFRegular.font, size: 14))
                .foregroundColor(ColorManager.textDefaultColor.color)
                .frame(maxWidth: .infinity, alignment: .leading)

        }
    }
    
    private func goToSettingsButton() -> some View {
        Text("Go to settings")
            .font(.custom(FontsManager.SFSemibold.font, size: 20))
            .padding()
            .frame(maxWidth: .infinity)
            .background(ColorManager.buttonActiveColor.color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .onTapGesture {
                openAppSettings()
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 34
                                , trailing: 0))
    }
    
    private func createiOS17Tutorial() -> some View {
        VStack {
            HStack() {
                Image(IconsManager.icFirst.image)
                    .frame(width: 24, height: 24)
                Text("Open \"Settings\"")                                .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 12)
            Text("On your device's home screen, find and tap the")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(FontsManager.SFRegular.font, size: 14))
                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                .padding(.bottom, 4)
            
            HStack(spacing: 10) {
                Image(IconsManager.icSettingsSmall.image)
                    .frame(width: 24, height: 24)
                Text("Settings")
                    .font(.custom(FontsManager.SFRegular.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 16)
            
            Separator()
                .padding(.bottom, 16)
            
            HStack(spacing: 10) {
                Image(IconsManager.icSecond.image)
                    .frame(width: 24, height: 24)
                Text("Tap on your Apple ID (your name at the top)")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 12)
            
            Text("On your device's home screen, go to Settings and tap the on your Apple ID (your name at the top)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(FontsManager.SFRegular.font, size: 14))
                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                .padding(.bottom, 16)
            
            Separator()
                .padding(.bottom, 16)
            
            HStack(spacing: 10) {
                Image(IconsManager.icThird.image)
                    .frame(width: 24, height: 24)
                Text("Go to Password & Security")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 16)
            
            Separator()
                .padding(.bottom, 16)
            
            HStack(spacing: 10) {
                Image(IconsManager.icFourth.image)
                    .frame(width: 24, height: 24)
                Text("Scroll down and select Recovery Key")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 16)
            
            Separator()
                .padding(.bottom, 16)
            
            
            HStack(spacing: 10) {
                Image(IconsManager.icFifth.image)
                    .frame(width: 24, height: 24)
                Text("Toggle the switch to On to enable the feature")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 16)
            
            Separator()
                .padding(.bottom, 16)
            
            
            HStack(spacing: 10) {
                Image(IconsManager.icSixth.image)
                    .frame(width: 24, height: 24)
                Text("Follow the on-screen instructions to generate a Recovery Key")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 16)
            
            Separator()
                .padding(.bottom, 16)
            
            
            HStack(spacing: 10) {
                Image(IconsManager.icSeventh.image)
                    .frame(width: 24, height: 24)
                Text("Save the 28-character key in a secure place")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 16)
        }
    }
    
    private func getDeviceLockDetailsViewState() -> DeviceLockDetailsViewState {
        if UserSessionManager.shared.isDeviceLockEnabled {
            if #available(iOS 17.0, *) {
                return .iOS17Tutorial
            } else {
                return .defaultTutorial
            }
        } else {
            return .defaultTutorial
        }
    }
}

#Preview {
    DeviceLockDetailsScreen()
}

//
//  IOSVersionCkeckModule.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 25/02/25.
//

import SwiftUI

struct IOSVersionCkeckModule: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        VStack(spacing: 12) {
                            Text(getHeaderTextAndColor().text)                                .font(.custom(FontsManager.SFbold.font, size: 28))
                                .foregroundColor(getHeaderTextAndColor().color)
                            
                            Text("Update your device to the latest version")        .font(.custom(FontsManager.SFSemibold.font, size: 18))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                        }
                        .padding(.bottom, 12)
                        
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
                            Text("Navigate to General Settings")
                                .font(.custom(FontsManager.SFSemibold.font, size: 14))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 12)
                        
                        Image(IconsManager.icSettingsCell.image)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom, 16)
                        
                        
                        Separator()
                            .padding(.bottom, 16)
                        
                        HStack(spacing: 10) {
                            Image(IconsManager.icThird.image)
                                .frame(width: 24, height: 24)
                            Text("Check for Software Update")
                                .font(.custom(FontsManager.SFSemibold.font, size: 14))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 12)
                        
                        Image(IconsManager.icGeneralSettings.image)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 16)
                        
                        Separator()
                            .padding(.bottom, 16)
                        
                        HStack(spacing: 10) {
                            Image(IconsManager.icFourth.image)
                                .frame(width: 24, height: 24)
                            Text("Install the Update")
                                .font(.custom(FontsManager.SFSemibold.font, size: 14))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 12)
                        
                        Image(IconsManager.icAvailableUpdate.image)
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 16)
                        
                        Separator()
                            .padding(.bottom, 16)
                        
                        Spacer()
                        
                        Text("Ensure your device is connected to Wi-Fi and has at least 50% battery, or connect it to a charger during the update.")
                            .font(.custom(FontsManager.SFRegular.font, size: 14))
                            .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                        
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
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0
                                                , trailing: 0))
                    }
                    .padding(.bottom, 20)
                    .padding(.top, Constants.isIPad ? 88 : 16)
                    .padding(.horizontal, Constants.isIPad ? 190 : 24)
                    .frame(height: geometry.size.height)
                }
                .scrollIndicators(.hidden)
                .background(ColorManager.mainBackground.color)
            }
        }
        .navigationTitle("Update your device")
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
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    private func getHeaderTextAndColor() -> (text: String, color: Color) {
        if UserSessionManager.shared.isDeviceVersionOutdated {
            return ("Your iOS is outdated.", ColorManager.attentionTextColor.color)
        } else {
            return ("iOS is up to date.", ColorManager.buttonActiveColor.color)
        }
    }
}

#Preview {
    IOSVersionCkeckModule()
}

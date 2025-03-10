//
//  MaliciousSitesProtectionScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct MaliciousSitesProtectionScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
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
                            Text("Select the Applications")
                                .font(.custom(FontsManager.SFSemibold.font, size: 14))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 12)
                        
                        HStack(spacing: 10) {
                            Image(IconsManager.icApplications.image)
                                .frame(width: 24, height: 24)
                            Text("Applications")
                                .font(.custom(FontsManager.SFRegular.font, size: 14))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 12)
                        
                        HStack(spacing: 10) {
                            Image(IconsManager.icThird.image)
                                .frame(width: 24, height: 24)
                            Text("Go to Safari Settings")
                                .font(.custom(FontsManager.SFSemibold.font, size: 14))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 12)
                        
                        Text("Scroll down and select \"Safari\"")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                            .font(.custom(FontsManager.SFRegular.font, size: 14))
                            .padding(.bottom, 4)
                        
                        HStack(spacing: 10) {
                            Image(IconsManager.icSafari.image)
                                .frame(width: 24, height: 24)
                            Text("Safari")
                                .font(.custom(FontsManager.SFRegular.font, size: 14))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 16)
                        
                        Separator()
                            .padding(.bottom, 16)
                        
                        HStack(spacing: 10) {
                            Image(IconsManager.icFourth.image)
                                .frame(width: 24, height: 24)
                            Text("Select Content Blockers / Extension")
                                .font(.custom(FontsManager.SFSemibold.font, size: 14))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 24)
                        
                        HStack(spacing: 5) {
                            Text("Content Blockers")
                                .font(.custom(FontsManager.SFRegular.font, size: 14))
                                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                                .padding(.leading, 16)
                            Spacer()
                            Text("1")
                                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                                .font(.custom(FontsManager.SFRegular.font, size: 14))
                            Image(IconsManager.icChevronRight.image)
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 16)
                        }
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom, 16)
                        
                        Separator()
                            .padding(.bottom, 16)
                        
                        HStack(spacing: 10) {
                            Image(IconsManager.icFifth.image)
                                .frame(width: 24, height: 24)
                            Text("Turn ON")
                                .font(.custom(FontsManager.SFSemibold.font, size: 14))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 12)
                        
                        HStack(spacing: 6) {
                            Image(IconsManager.icAppiconSmall.image)
                                .frame(width: 24, height: 24)
                                .padding(.leading, 16)
                            Text("Privacy Fortness")
                                .padding(.leading, 4)
                                .font(.custom(FontsManager.SFRegular.font, size: 14))
                                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                            Spacer()
                            Image(IconsManager.icSwitcher.image)
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 32)
                        }
                        .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        Spacer()
                        
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
                    }
                    .padding(.bottom, 20)
                    .padding(.top, Constants.isIPad ? 88 : 16)
                    .padding(.horizontal, Constants.isIPad ? 190 : 24)
                }
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
        }
        .navigationTitle("Malicious Sites Protection")
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
}

#Preview {
    MaliciousSitesProtectionScreen()
}

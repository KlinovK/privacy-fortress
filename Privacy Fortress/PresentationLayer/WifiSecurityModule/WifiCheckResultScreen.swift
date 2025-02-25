//
//  WifiCheckResultScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct WifiCheckResultScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State var viewState: WifiCheckResultScreenViewState = UserSessionManager.shared.isSecureNetwork ? .wifiIsSecure : .wifiIsNotSecure
    @State private var showHomeWifiOverlay = false
    @State private var showPublicWifiOverlay = false

    var body: some View {
        
        GeometryReader { geometry in
            switch viewState {
            case .wifiIsSecure:
                showWifiIsNotSecureViewState()
                
                if showHomeWifiOverlay {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    presentHomeWifiTutorial(geometry: geometry)
                }
                
                if showPublicWifiOverlay {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    presentPublicWifiTutorial()
                }
                
            case .wifiIsNotSecure:
                showWifiIsNotSecureViewState()
                
                if showHomeWifiOverlay {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    presentHomeWifiTutorial(geometry: geometry)
                }
                
                if showPublicWifiOverlay {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    presentPublicWifiTutorial()
                }
                
               
            }
        }
    
    }
    
    private func showWifiIsNotSecureViewState() -> some View {
        
        ZStack {
                VStack() {
                    Text("Your Wi-Fi is insecure")
                        .font(.custom(FontsManager.SFSemibold.font, size: 24))
                        .foregroundColor(ColorManager.attentionTextColor.color)
                        .padding(.bottom, 36)
                    Text("Select the type of network you used during the check:")
                        .font(.custom(FontsManager.SFSemibold.font, size: 18))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 59)
                    
                    HStack(spacing: 16) {
                        Image(IconsManager.icHomeWifi.image)
                            .frame(width: 110, height: 110)
                            .cornerRadius(10)
                            .onTapGesture {
                                showHomeWifiOverlay.toggle()
                            }
                        
                        Image(IconsManager.icPublicWifi.image)
                            .frame(width: 110, height: 110)
                            .cornerRadius(10)
                            .onTapGesture {
                                showPublicWifiOverlay.toggle()
                            }
                    }
                    
                    Spacer()
                    addBackAction()
                }
        }
        
        .padding(.horizontal, Constants.isIPad ? 190 : 16)
        .padding(.top, Constants.isIPad ? 479 : 232)
        .background(ColorManager.mainBackground.color)
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
    
    private func showWifiIsSecureViewState() -> some View {
        VStack() {
            Text("Your Wi-Fi is secure")
                .font(.custom(FontsManager.SFSemibold.font, size: 24))
                .foregroundColor(ColorManager.buttonActiveColor.color)
            Spacer()
            addBackAction()
        }
        .padding(.horizontal, Constants.isIPad ? 190 : 16)
        .padding(.top, Constants.isIPad ? 479 : 232)
        .background(ColorManager.mainBackground.color)
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
    
    private func addBackAction() -> some View {
        VStack {
            Text("Remember to check Wi-Fi security in unfamiliar locations.")
                .font(.custom(FontsManager.SFRegular.font, size: 14))
                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)

            Button(action: {
                dismiss()
            }) {
                Text("Back to Wi-Fi security check")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.custom(FontsManager.SFSemibold.font, size: 20))
                    .background(ColorManager.buttonActiveColor.color)
                    .background(ColorManager.buttonActiveColor.color)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    private func presentHomeWifiTutorial(geometry: GeometryProxy) -> some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack {
                HStack() {
                    Image(IconsManager.icWifiAttention.image)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Follow these steps to improve its security:")
                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image(IconsManager.icWifiAttention.image)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Update your router password.")
                        .font(.custom(FontsManager.SFRegular.font, size: 16))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image("")
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Use a strong, unique password that combines letters, numbers, and symbols.")
                        .font(.custom(FontsManager.SFRegular.font, size: 14))
                        .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image(IconsManager.icWifiAttention.image)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Update your router password.")
                        .font(.custom(FontsManager.SFRegular.font, size: 16))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image("")
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Use a strong, unique password that combines letters, numbers, and symbols.")
                        .font(.custom(FontsManager.SFRegular.font, size: 14))
                        .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image(IconsManager.icWifiAttention.image)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Update your router password.")
                        .font(.custom(FontsManager.SFRegular.font, size: 16))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image("")
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Use a strong, unique password that combines letters, numbers, and symbols.")
                        .font(.custom(FontsManager.SFRegular.font, size: 14))
                        .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image(IconsManager.icWifiAttention.image)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Update your router password.")
                        .font(.custom(FontsManager.SFRegular.font, size: 16))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image("")
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Use a strong, unique password that combines letters, numbers, and symbols.")
                        .font(.custom(FontsManager.SFRegular.font, size: 14))
                        .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image(IconsManager.icWifiAttention.image)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Update your router password.")
                        .font(.custom(FontsManager.SFRegular.font, size: 16))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image("")
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Use a strong, unique password that combines letters, numbers, and symbols.")
                        .font(.custom(FontsManager.SFRegular.font, size: 14))
                        .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image(IconsManager.icWifiAttention.image)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Update your router password.")
                        .font(.custom(FontsManager.SFRegular.font, size: 16))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                HStack() {
                    Image("")
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Use a strong, unique password that combines letters, numbers, and symbols.")
                        .font(.custom(FontsManager.SFRegular.font, size: 14))
                        .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)

                Button("Back") {
                    showHomeWifiOverlay.toggle()
                }
                .font(.custom(FontsManager.SFSemibold.font, size: 20))
                .padding()
                .frame(width: geometry.size.width - 64, height: 61)
                .background(ColorManager.buttonActiveColor.color)
                .foregroundColor(.white)
                .cornerRadius(11)
            }
            .frame(width: geometry.size.width - 32, height: geometry.size.height - 120)
            .background(Color.white)
            .cornerRadius(16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    private func presentPublicWifiTutorial() -> some View {
        VStack(spacing: 20) {
            Text("This is an overlay!")
                .font(.title)
                .foregroundColor(.black)
            
            Button("Close") {
                showPublicWifiOverlay.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .background(Color.white)
        .cornerRadius(16)
    }

    
}

#Preview {
    WifiCheckResultScreen()
}

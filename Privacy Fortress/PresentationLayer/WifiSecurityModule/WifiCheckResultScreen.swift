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
                showWifiIsSecureViewState()
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
                    presentPublicWifiTutorial(geometry: geometry)
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
        
        .padding(.bottom, 20)
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
            Image(IconsManager.icWifiIsSecureBig.image)
                .resizable()
                .scaledToFit()
                .frame(width: 201, height: 209)
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

                createTutorialCell(type: .routerPassword)
                createTutorialCell(type: .networkName)
                createTutorialCell(type: .switchToWPA3)
                createTutorialCell(type: .updateRouterFirmware)
                createTutorialCell(type: .createGuestNetwork)
                createTutorialCell(type: .disableWPS)

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
    
    private func presentPublicWifiTutorial(geometry: GeometryProxy) -> some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack {
                HStack() {
                    Image(IconsManager.icWifiAttention.image)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                    Text("Follow these steps to stay safe on a public network:")
                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.horizontal, 16)

                createTutorialCell(type: .avoidAccessingSensitiveData)
                createTutorialCell(type: .useVPN)
                createTutorialCell(type: .turnOffSharing)
                createTutorialCell(type: .stickToSecureNetworks)
                createTutorialCell(type: .disconnect)

                Button("Back") {
                    showPublicWifiOverlay.toggle()
                }
                .font(.custom(FontsManager.SFSemibold.font, size: 20))
                .padding()
                .frame(width: geometry.size.width - 64, height: 61)
                .background(ColorManager.buttonActiveColor.color)
                .foregroundColor(.white)
                .cornerRadius(11)
            }
            .frame(width: geometry.size.width - 32, height: geometry.size.height - 235)
            .background(Color.white)
            .cornerRadius(16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    private func createTutorialCell(type: TutorialCellType) -> some View {
        VStack {
            HStack() {
                Image(createImageCell(type: type))
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 12)
                Text(createTitleAndSubtitle(type: type).0)
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
                Text(createTitleAndSubtitle(type: type).1)
                    .font(.custom(FontsManager.SFRegular.font, size: 14))
                    .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
            .padding(.horizontal, 16)
        }
    }
    
    private func createTitleAndSubtitle(type: TutorialCellType) -> (String, String) {
        switch type {
        case .routerPassword:
            return ("Update your router password.", "Use a strong, unique password that combines letters, numbers, and symbols.")
        case .networkName:
            return ("Change your network name", "Avoid using names that give away personal information")
        case .switchToWPA3:
            return ("Switch to WPA3 or WPA2 encryption", "Check your router settings and switch to a secure encryption protocol.")
        case .updateRouterFirmware:
            return ("Update your router's firmware", "Ensure your router has the latest security updates installed.")
        case .createGuestNetwork:
            return ("Create a guest network", "Use a separate network for visitors to keep your main network private.")
        case .disableWPS:
            return ("Disable WPS (Wi-Fi Protected Setup)", "This feature can be exploited to gain unauthorized access.")
        case .avoidAccessingSensitiveData:
            return ("Avoid accessing sensitive information", "Do not log in to banking or other critical accounts.")
        case .useVPN:
            return ("Use a VPN", "Encrypt your connection to protect your data.")
        case .turnOffSharing:
            return ("Turn off sharing", "Disable file sharing and make your device non-discoverable.")
        case .stickToSecureNetworks:
            return ("Stick to secure websites", "Look for \"https://\" in the URL before entering any information.")
        case .disconnect:
            return ("Disconnect when not in use", "Log out of the public network when you're done.")
        }
    }
    
    private func createImageCell(type: TutorialCellType) -> String {
        switch type {
        case .routerPassword:
            return IconsManager.icRouterPassword.image
        case .networkName:
            return IconsManager.icNetworkName.image
        case .switchToWPA3:
            return IconsManager.icSwitchToWPA3.image
        case .updateRouterFirmware:
            return IconsManager.icUpdateRouterFirmware.image
        case .createGuestNetwork:
            return IconsManager.icCreateGuestNetwork.image
        case .disableWPS:
            return IconsManager.icDisableWPS.image
        case .avoidAccessingSensitiveData:
            return IconsManager.icAvoidAccessing.image
        case .useVPN:
            return IconsManager.icUseVPN.image
        case .turnOffSharing:
            return IconsManager.icTurnOffSharing.image
        case .stickToSecureNetworks:
            return IconsManager.icStickToSecureWebsites.image
        case .disconnect:
            return IconsManager.icDisconnect.image
        }
    }
    
}

#Preview {
    WifiCheckResultScreen()
}

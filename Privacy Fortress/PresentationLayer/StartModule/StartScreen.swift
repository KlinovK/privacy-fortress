//
//  StartScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct StartScreenView: View {
    
    @State private var viewState: StartScreenViewState = .start
    @StateObject private var viewModel = StartScreenViewModel()

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 12) {
                        switch viewState {
                        case .start:
                            Image(IconsManager.icAppLogoStartScreen.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 114, height: 138)
                            
                            Text("Your Privacy & Security Check")
                                .font(.custom(FontsManager.SFSemibold.font, size: 20))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                            presentCardViews()
                            Spacer()
                            Button(action: {
                                changeViewState(state: .isAnalyzing)
                                Task {
                                    await viewModel.startWiFiSecurityCheck()
                                    await viewModel.startPersonalDataProtectionCheck()
                                    await viewModel.startSystemSecurityCheck()
                                    await viewModel.startSafeStorageCheck()
                                }
                            }) {
                                Text("Start Scan")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .font(.custom(FontsManager.SFSemibold.font, size: 20))
                                    .background(ColorManager.buttonActiveColor.color)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                        case .isAnalyzing:
                            CircularProgressView(progress: viewModel.progress)
                                .padding(.bottom, 14)
                            Text("Analyzing Your Device...")
                                .font(.custom(FontsManager.SFSemibold.font, size: 20))
                                .foregroundColor(ColorManager.textDefaultColor.color)
                                .padding(.bottom, 24)
                            presentAnalyzingCardViews(isNoIssuesState: false)
                            
                            Spacer()
                            NavigationLink(destination: ResultsScreen()) {
                                Text("View Results")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .font(.custom(FontsManager.SFSemibold.font, size: 20))
                                    .background(viewModel.progress < 1 ? ColorManager.buttonDisabledColor.color : ColorManager.buttonActiveColor.color)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .disabled(viewModel.progress < 1)
                            
                        case .isNoIssuesState:
                            Image(IconsManager.icAppLogoStartScreen.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 114, height: 138)
                            Text("We found no critical security bugs")
                                .font(.custom(FontsManager.SFSemibold.font, size: 24))
                                .padding(.bottom, 24)
                                .foregroundColor(ColorManager.buttonActiveColor.color)
                            
                            presentAnalyzingCardViews(isNoIssuesState: true)
                            
                            Spacer()
                            Button(action: {
                                changeViewState(state: .isAnalyzing)
                                Task {
                                    await viewModel.startWiFiSecurityCheck()
                                    await viewModel.startPersonalDataProtectionCheck()
                                    await viewModel.startSystemSecurityCheck()
                                    await viewModel.startSafeStorageCheck()
                                }
                            }) {
                                Text("Scan Again")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .font(.custom(FontsManager.SFSemibold.font, size: 20))
                                    .background(ColorManager.buttonActiveColor.color)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        case .longTimeNoScan:
                            Image(IconsManager.icAppLogoWarning.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 114, height: 138)
                            VStack {
                                Text("Long time no scan!")
                                    .font(.custom(FontsManager.SFbold.font, size: 26))
                                    .foregroundColor(ColorManager.warningTextColor.color)
                                Text("Your device is at risk")
                                    .font(.custom(FontsManager.SFSemibold.font, size: 22))
                                    .foregroundColor(ColorManager.warningTextColor.color)
                            }
                            .padding(.bottom, 24)
                          
                            presentCardViews()

                            Spacer()
                            Button(action: {
                                changeViewState(state: .isAnalyzing)
                                Task {
                                    await viewModel.startWiFiSecurityCheck()
                                    await viewModel.startPersonalDataProtectionCheck()
                                    await viewModel.startSystemSecurityCheck()
                                    await viewModel.startSafeStorageCheck()
                                }
                            }) {
                                Text("Scan Now")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .font(.custom(FontsManager.SFSemibold.font, size: 20))
                                    .background(ColorManager.buttonActiveColor.color)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.top, Constants.isIPad ? 88 : 21)
                    .padding(.horizontal, Constants.isIPad ? 190 : 16)
                    .frame(height: geometry.size.height)
                }
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
        }
    }
    
    private func changeViewState(state: StartScreenViewState) {
        viewState = state
    }
    
    private func presentCardViews() -> some View {
        VStack(spacing: 8) {
            StartCardViewView(title: "Wi-Fi Security", subtitle: "Ensure your Wi-Fi connection is safe and secure", imageName: IconsManager.icWifiSecurity.image)
            StartCardViewView(title: "Personal Data Protection", subtitle: "Monitor and protect your personal information", imageName: IconsManager.icPersonalDataSecurity.image)
            StartCardViewView(title: "System Security", subtitle: "Check your device settings for optimal security", imageName: IconsManager.icSystemSecurity.image)
            StartCardViewView(title: "Safe Storage", subtitle: "Securely store your media and passwords.", imageName: IconsManager.icPersonalStorage.image)
        }
    }
    
    private func presentAnalyzingCardViews(isNoIssuesState: Bool) -> some View {
        VStack(spacing: 8) {
            AnalyzingCardView(title: "Wi-Fi Security", imageName: IconsManager.icWifiSecurity.image, progress: viewModel.wifiSecurityProgress, isNoIssuesState: isNoIssuesState)
            AnalyzingCardView(title: "Personal Data Protection", imageName: IconsManager.icPersonalDataSecurity.image, progress: viewModel.personalDataProtectionProgress, isNoIssuesState: isNoIssuesState)
            AnalyzingCardView(title: "System Security", imageName: IconsManager.icSystemSecurity.image, progress: viewModel.systemSecurityProgress, isNoIssuesState: isNoIssuesState)
            AnalyzingCardView(title: "Safe Storage", imageName: IconsManager.icPersonalStorage.image, progress: viewModel.safeStorageProgress, isNoIssuesState: isNoIssuesState)
        }
    }
}

#Preview {
    StartScreenView()
}


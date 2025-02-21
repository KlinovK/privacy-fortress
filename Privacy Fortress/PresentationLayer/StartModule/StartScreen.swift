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
                                .font(.custom(FontsManager.SFbold.font, size: 20))
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
                                    .font(.custom(FontsManager.SFbold.font, size: 20))
                                    .background(ColorManager.buttonActiveColor.color)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                        case .isAnalyzing:
                            CircularProgressView(progress: viewModel.progress)
                                .padding(.bottom, 14)
                            Text("Analyzing Your Device...")
                                .font(.custom(FontsManager.SFbold.font, size: 20))
                                .padding(.bottom, 24)
                            presentAnalyzingCardViews()
                            
                            Spacer()
                            NavigationLink(destination: ResultsScreen()) {
                                Text("View Results")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .font(.custom(FontsManager.SFbold.font, size: 20))
                                    .background(viewModel.progress < 1 ? ColorManager.buttonDisabledColor.color : ColorManager.buttonActiveColor.color)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .disabled(viewModel.progress < 1)
                            
                        case .isFinishedAnalyzing:
                            Text("")
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
    
    private func presentAnalyzingCardViews() -> some View {
        VStack(spacing: 8) {
            AnalyzingCardView(title: "Wi-Fi Security", subtitle: "", imageName: IconsManager.icWifiSecurity.image, progress: viewModel.wifiSecurityProgress, type: .wifiSecurity)
            AnalyzingCardView(title: "Personal Data Protection", subtitle: "", imageName: IconsManager.icPersonalDataSecurity.image, progress: viewModel.personalDataProtectionProgress, type: .personalDataProtection)
            AnalyzingCardView(title: "System Security", subtitle: "Internal storage/addon/system file.idf", imageName: IconsManager.icSystemSecurity.image, progress: viewModel.systemSecurityProgress, type: .systemSecurity)
            AnalyzingCardView(title: "Safe Storage", subtitle: "", imageName: IconsManager.icPersonalStorage.image, progress: viewModel.safeStorageProgress, type: .safeStorage)
        }
    }
}

#Preview {
    StartScreenView()
}


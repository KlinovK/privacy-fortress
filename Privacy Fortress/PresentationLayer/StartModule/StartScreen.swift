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
            StartCardViewView(issueType: .wifiSecurity)
            StartCardViewView(issueType: .personalDataProtection)
            StartCardViewView(issueType: .systemSecurity)
            StartCardViewView(issueType: .safeStorage)
        }
    }
    
    private func presentAnalyzingCardViews(isNoIssuesState: Bool) -> some View {
        VStack(spacing: 8) {
            AnalyzingCardView(issueType: .wifiSecurity, isNoIssuesState: isNoIssuesState, progress: viewModel.wifiSecurityProgress)
            AnalyzingCardView(issueType: .personalDataProtection, isNoIssuesState: isNoIssuesState, progress: viewModel.personalDataProtectionProgress)
            AnalyzingCardView(issueType: .systemSecurity, isNoIssuesState: isNoIssuesState, progress: viewModel.systemSecurityProgress)
            AnalyzingCardView(issueType: .safeStorage, isNoIssuesState: isNoIssuesState, progress: viewModel.safeStorageProgress)
        }
    }
}

#Preview {
    StartScreenView()
}


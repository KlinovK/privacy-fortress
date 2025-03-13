//
//  PaywallScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct PaywallScreen: View {
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                Task {
                                    do {
                                        _ = try await ApphudManager.shared.restorePurchases()
                                    } catch {
                                        print("Restore failed: \(error)")
                                    }
                                }
                            }) {
                                Text("Restore")
                                    .frame(width: 60, height: 20, alignment: .trailing)
                                    .background(Color.clear)
                                    .font(.custom(FontsManager.SFRegular.font, size: 18))
                                    .foregroundColor(ColorManager.buttonActiveColor.color)
                            }
                        }
                        .padding(.bottom, 14)

                        Image(IconsManager.icAppLogoStartScreen.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 180)
                            .padding(.bottom, 41)
                        
                        Text("Unlock Full Protection")
                            .foregroundColor(ColorManager.buttonActiveColor.color)
                            .font(.custom(FontsManager.SFSemibold.font, size: 24))
                            .padding(.bottom, 25)
                        
                        ZStack(alignment: .topLeading) {
                            Color.white
                                .frame(height: 223)
                                .cornerRadius(16)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                createPaywallViewCell(generalIssueType: .wifiSecurity)
                                createPaywallViewCell(generalIssueType: .safeStorage)
                                createPaywallViewCell(generalIssueType: .personalDataProtection)
                                createPaywallViewCell(generalIssueType: .systemSecurity)
                                createPaywallViewCell(generalIssueType: nil)
                            }
                            .frame(height: 183)
                            .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 32)
                        
                        Text("3 days free then $9.99/week")
                            .font(.custom(FontsManager.SFlight.font, size: 14))
                            .foregroundColor(ColorManager.textDefaultColor.color)
                        Text("Auto-renewable, cancel anytime")
                            .font(.custom(FontsManager.SFlight.font, size: 14))
                            .padding(.bottom, 32)
                            .foregroundColor(ColorManager.textDefaultColor.color)
                        
                        Spacer()
                        
                        Button(action: {
                            Task {
                                do {
                                    _ = try await ApphudManager.shared.makePurchase()
                                } catch {
                                    print("Purchase failed: \(error)")
                                }
                            }
                        }) {
                            Text("Protect Now")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .font(.custom(FontsManager.SFSemibold.font, size: 20))
                                .background(ColorManager.attentionTextColor.color)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 0)
                        
                        HStack(spacing: 50) {
                            Text("Terms of Use")
                                .font(.custom(FontsManager.SFlight.font, size: 14))
                                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                                .underline()
                                .onTapGesture {
                                    openURL(Constants.termsAndConditionsURLString)
                                }

                            Text("Privacy Policy")
                                .font(.custom(FontsManager.SFlight.font, size: 14))
                                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                                .underline()
                                .onTapGesture {
                                    openURL(Constants.privacyPolicyURLString)
                                }
                            
                            Button(action: {
                                AppFlyerManager.shared.logEvent(name: "paywall_skipped", productId: Constants.productIdentifierSubscription)
                            }) {
                                NavigationLink(destination: MainScreen()) {
                                    Text("Skip")
                                        .font(.custom(FontsManager.SFlight.font, size: 14))
                                        .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                                        .underline()
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 3, leading: 26, bottom: 16, trailing: 26))
                    }
                }
                .padding(.top, Constants.isIPad ? 30 : 21)
                .padding(.horizontal, Constants.isIPad ? 190 : 24)
                .frame(height: geometry.size.height)
                .onAppear(perform: {
                    AppFlyerManager.shared.logEvent(name: "paywall_shown", productId: Constants.productIdentifierSubscription)
                })
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private func createPaywallViewCell(generalIssueType: GeneralIssueType?) -> some View {
        HStack {
            Image(IconsManager.icDiamond.image)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            Text(gerCellTitle(issueType: generalIssueType))
                .foregroundColor(ColorManager.textDefaultColor.color)
                .font(.custom(FontsManager.SFRegular.font, size: 18))
        }
    }
    
    private func gerCellTitle(issueType: GeneralIssueType?) -> String {
        switch issueType {
        case .wifiSecurity:
            return "Advanced Wi-Fi Protection"
        case .safeStorage:
            return "Malicious Sites Filter"
        case .personalDataProtection:
            return "Data Breach Monitoring"
        case .systemSecurity:
            return "Hidden File Storage"
        default:
            return "Password Vault"
        }
    }
    
    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}

#Preview {
    PaywallScreen()
}

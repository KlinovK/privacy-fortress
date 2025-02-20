//
//  MainScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct MainScreen: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                updatedHeaderView()
                NavigationLink(destination: SettingsScreen()) {
                    Text("Activate Your Full Protection Now! ")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                .padding(EdgeInsets(top: 22, leading: 0, bottom: 24, trailing: 0))
            }
            
            .scrollIndicators(.hidden)
            .padding(.horizontal, 24)
            .background(Color.gray.opacity(0.1))
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private func setupResultsCardViews() -> some View {
        VStack(spacing: 12) {
            MainCardViewView(headerTitle: "Wi-Fi Security", firstRowTitle: "Malicious Sites Protection:", firstRowSubtitle: "Harmful websites will be blocked for your safety.", secondRowTitle: "Wi-Fi Security Check:", secondRowSubtitle: "This network may expose your data to unauthorized access or attacks.", imageName: "swift")
            MainCardViewView(headerTitle: "Personal Data Protection", firstRowTitle: "MData Breach Monitoring:", firstRowSubtitle: "Detect if your personal data has been leaked from the services you use.", secondRowTitle: "Find My:", secondRowSubtitle: "Your device can be located if lost or stolen.", imageName: "swift")
            MainCardViewView(headerTitle: "System Security", firstRowTitle: "Device Lock:", firstRowSubtitle: "Ensure Device Lock is enabled to secure your device from unauthorized access.", secondRowTitle: "iOS Version Check:", secondRowSubtitle: "Update your device to ensure optimal security and performance.", imageName: "swift")
            MainCardViewView(headerTitle: "Safe Storage", firstRowTitle: "Media Safe", firstRowSubtitle: "Securely store your photos and videos!", secondRowTitle: "Password Vault", secondRowSubtitle: "Securely store and manage your passwords!", imageName: "swift")
        }
        .padding(.top, 0)
    }
    
    private func updatedHeaderView() -> some View {
        VStack(spacing: 20) {
            ZStack {
                Image(systemName: "applelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 116, height: 116)
                
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: PaywallScreen()) {
                            Text("")
                                .frame(width: 44, height: 44)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()

                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
           
            Text("Check Issues to Improve \n Your Device Security and Stay Protected")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                setupResultsCardViews()
        }
    }
}

#Preview {
    MainScreen()
}

struct MainCardViewView: View {
    
    let headerTitle: String
    let firstRowTitle: String
    let firstRowSubtitle: String
    let secondRowTitle: String
    let secondRowSubtitle: String
    let imageName: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            Color.white
                .cornerRadius(16)
            
            createCellWithType()

        }
        .frame(maxWidth: .infinity, maxHeight: false ? 272 : 283)
        
    }
    
    private func createCellWithType() -> some View {
        VStack {
            HStack(spacing: 5.5) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                Text(headerTitle)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Text(firstRowTitle)
                    .font(.system(size: 12, weight: .light))

                BadgeView()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(firstRowSubtitle)
                .font(.system(size: 12, weight: .light))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            NavigationLink(destination: returnDestination(entryPoint: .wifiSecurityCheck)) {
                Text("Details")
                    .foregroundColor(.green)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Separator()
            
            HStack {
                Text(secondRowTitle)
                    .font(.system(size: 12, weight: .light))
                BadgeView()
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text(secondRowSubtitle)
                .font(.system(size: 12, weight: .light))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            NavigationLink(destination: returnDestination(entryPoint: .maliciousSitesProtection)) {
                Text("Details")
                    .foregroundColor(.green)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)


        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
    }
    
    private func returnDestination(entryPoint: CheckIssueEntryPoint) -> some View {
        switch entryPoint {
        case .maliciousSitesProtection:
            return MaliciousSitesProtectionScreen()
        case .wifiSecurityCheck:
            return WifiSecurityCheckScreen()
        }
    }
    
}

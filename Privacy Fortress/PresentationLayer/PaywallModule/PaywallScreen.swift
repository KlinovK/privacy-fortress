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
                            NavigationLink(destination: MainScreen()) {
                                Text("Restore")
                                    .frame(width: 60, height: 20, alignment: .trailing)
                                    .background(Color.clear)
                                    .foregroundColor(ColorManager.buttonActiveColor.color)
                                    .font(.custom(FontsManager.SFRegular.font, size: 18))
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
                                HStack {
                                    Image(systemName: "applelogo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text("Advanced Wi-Fi Protection")
                                        .foregroundColor(ColorManager.textDefaultColor.color)
                                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                                }
                                
                                HStack {
                                    Image(systemName: "applelogo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text("Malicious Sites Filter")
                                        .foregroundColor(ColorManager.textDefaultColor.color)
                                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                                }
                                HStack {
                                    Image(systemName: "applelogo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text("Data Breach Monitoring")
                                        .foregroundColor(ColorManager.textDefaultColor.color)
                                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                                }
                                HStack {
                                    Image(systemName: "applelogo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text("Hidden File Storage")
                                        .foregroundColor(ColorManager.textDefaultColor.color)
                                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                                }
                                HStack {
                                    Image(systemName: "applelogo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text("Password Vault")
                                        .foregroundColor(ColorManager.textDefaultColor.color)
                                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                                }
                            }
                            .frame(height: 183)
                            .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 32)
                        
                        Text("3 days free then $9.99/week")
                            .font(.system(size: 14, weight: .light))
                        Text("Auto-renewable, cancel anytime")
                            .font(.system(size: 14, weight: .light))
                            .padding(.bottom, 32)
                        
                        Spacer()
                        
                        NavigationLink(destination: MainScreen()) {
                            Text("Resolve All Issues")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 0)
                        
                        HStack(spacing: 50) {
                            NavigationLink(destination: MainScreen()) {
                                Text("Terms of Use")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(.blue)
                            }
                            NavigationLink(destination: MainScreen()) {
                                Text("Privacy Policy")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(.blue)
                            }
                            NavigationLink(destination: MainScreen()) {
                                Text("Skip")
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(.blue)
                            }
                            
                        }
                        .padding(EdgeInsets(top: 3, leading: 26, bottom: 16, trailing: 26))
                    }
                    .padding(.top, Constants.isIPad ? 88 : 21)
                    .padding(.horizontal, Constants.isIPad ? 190 : 24)
                    .frame(height: geometry.size.height)
                }
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
        }
    }
}

#Preview {
    PaywallScreen()
}

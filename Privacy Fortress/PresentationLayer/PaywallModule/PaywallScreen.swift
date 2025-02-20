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
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: MainScreen()) {
                            Text("Restore")
                                .frame(width: 60, height: 20, alignment: .trailing)
                                .background(Color.clear)
                                .foregroundColor(.green)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 74)
                    
                    Image(systemName: "applelogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 121, height: 146)
                        .padding(.bottom, 46)
                    
                    Text("Unlock Full Protection")
                        .padding(.bottom, 32)
                    
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
                            }
                            
                            HStack {
                                Image(systemName: "applelogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Text("Malicious Sites Filter")
                            }
                            HStack {
                                Image(systemName: "applelogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Text("Data Breach Monitoring")
                            }
                            HStack {
                                Image(systemName: "applelogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Text("Hidden File Storage")
                            }
                            HStack {
                                Image(systemName: "applelogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Text("Password Vault")
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
            }
            
            .scrollIndicators(.hidden)
            .padding(.horizontal, 24)
            .background(Color.gray.opacity(0.1))
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    PaywallScreen()
}

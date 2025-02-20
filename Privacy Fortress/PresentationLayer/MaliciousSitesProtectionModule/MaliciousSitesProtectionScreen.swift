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
            ScrollView {
                VStack {
                    HStack(spacing: 10) {
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                        Text("Open Settings")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                    
                    Text("On your device's home screen, find and tap the ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .padding(.bottom, 4)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                        Text("Settings")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)
                    
                    Separator()
                        .padding(.bottom, 16)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                        Text("Select the  Applications")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                        Text("Safari")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)
                    

                    HStack(spacing: 10) {
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                        Text("Go to Safari Settings")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                    
                    Text("Scroll down and select Safari")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .padding(.bottom, 4)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                        Text("Safari")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)
                    
                    Separator()
                        .padding(.bottom, 16)
                    
                    HStack(spacing: 10) {
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                        Text("Select Content Blockers / Extension")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 24)
                    
                    HStack(spacing: 5) {
                        Text("Content Blockers")
                            .padding(.leading, 16)
                        Spacer()
                        Text("1")
                        Image(systemName: "lock.shield.fill")
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
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                        Text("Turn ON")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                            .padding(.leading, 16)
                        Text("Privacy Fortness")
                        Spacer()
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 16)
                    }
                    .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.bottom, 16)
                    
                    Spacer()
                    
                    NavigationLink(destination: SettingsScreen()) {
                        Text("Go to Settings")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
                    
                }
                
                
            }
            .scrollIndicators(.hidden)
            .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
            .background(Color.gray.opacity(0.1))
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
}

#Preview {
    MaliciousSitesProtectionScreen()
}

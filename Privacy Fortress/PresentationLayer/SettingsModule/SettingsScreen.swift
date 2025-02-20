//
//  SettingsScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct SettingsScreen: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {

                    Image(systemName: "applelogo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, minHeight: 158, maxHeight: 158)
                        .padding(.bottom, 25)
                    
                    VStack(spacing: 8) {
                        HStack(spacing: 10) {
                            Image(systemName: "lock.shield.fill")
                                .frame(width: 24, height: 24)
                                .padding(.leading, 20)
                            Text("Rate Us")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 20)
                        }
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(Color.white)
                        .cornerRadius(10)
                        HStack(spacing: 10) {
                            Image(systemName: "lock.shield.fill")
                                .frame(width: 24, height: 24)
                                .padding(.leading, 20)
                            Text("Share App")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 20)
                        }
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(Color.white)
                        .cornerRadius(10)
                        HStack(spacing: 10) {
                            Image(systemName: "lock.shield.fill")
                                .frame(width: 24, height: 24)
                                .padding(.leading, 20)
                            Text("Privacy Policy")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 20)
                        }
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(Color.white)
                        .cornerRadius(10)
                        HStack(spacing: 10) {
                            Image(systemName: "lock.shield.fill")
                                .frame(width: 24, height: 24)
                                .padding(.leading, 20)
                            Text("Privacy Fortness")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 20)
                        }
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(Color.white)
                        .cornerRadius(10)
                        HStack(spacing: 10) {
                            Image(systemName: "lock.shield.fill")
                                .frame(width: 24, height: 24)
                                .padding(.leading, 20)
                            Text("Privacy Fortness")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 20)
                        }
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(Color.white)
                        .cornerRadius(10)
                        HStack(spacing: 10) {
                            Image(systemName: "lock.shield.fill")
                                .frame(width: 24, height: 24)
                                .padding(.leading, 20)
                            Text("Privacy Fortness")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 20)
                        }
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                        
                }
                
            }
            .scrollIndicators(.hidden)
            .padding(EdgeInsets(top: 20, leading: 24, bottom: 16, trailing: 24))
            .background(Color.gray.opacity(0.1))
        }
        .navigationTitle("Settings")
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
    SettingsScreen()
}

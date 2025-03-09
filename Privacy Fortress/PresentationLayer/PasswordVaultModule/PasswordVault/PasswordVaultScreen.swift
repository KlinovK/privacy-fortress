//
//  PasswordVaultScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 04/03/25.
//

import SwiftUI

struct PasswordVaultScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = PasswordVaultViewModel()
    @State private var navigateToPaywall = false

    private let columns = [
        GridItem(.flexible(), spacing: 1.5),
    ]

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    ScrollView {
                        VStack {
                            switch viewModel.viewState {
                            case .noPassword:
                                VStack {
                                    Image(IconsManager.icPasswordVault.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 164, height: 159)
                                        .padding(.bottom, 32)
                                        .padding(.top, Constants.isIPad ? 334 : 157)
                                    Text("Secure your digital life")
                                        .font(.custom(FontsManager.SFSemibold.font, size: 28))
                                        .foregroundColor(ColorManager.buttonActiveColor.color)
                                        .padding(.bottom, 12)
                                    
                                    Text("The First Step to Security: Save Your Password")
                                        .font(.custom(FontsManager.SFRegular.font, size: 18))
                                        .foregroundColor(ColorManager.textDefaultColor.color)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                }
                                
                            case .containsPasswords(let passwords):
                                ForEach(passwords) { item in
                                    PasswordItemView(item: item)
                                        .frame(maxWidth: .infinity)
                                }
                                .padding(.top, 20)
                            
                            }
                        }
                        .frame(minHeight: geometry.size.height, alignment: .top)
                    }
                    
                    Spacer()
                    
                    VStack {
                        NavigationLink(destination: AddPasswordScreen()) {
                            Text("Save Password")
                                .padding()
                                .frame(height: 64)
                                .frame(maxWidth: .infinity)
                                .background(ColorManager.buttonActiveColor.color)
                                .foregroundColor(.white)
                                .font(.custom(FontsManager.SFSemibold.font, size: 20))
                                .cornerRadius(10)
                        }
                    }
                }
                .frame(height: geometry.size.height)
            }
            .padding(.horizontal, Constants.isIPad ? 190 : 24)
            .background(getBackgroundColor())
            .navigationTitle("Password Vault")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .onAppear {
                viewModel.updateViewState(passwordItems: [])
            }
            .navigationDestination(isPresented: $navigateToPaywall) {
                PaywallScreen()
            }
            .overlay(
                SubscriptionAlertView(isPresented: $viewModel.isNeedToPresentSubscriptionAlert, onDismiss: { isNeedToPresentPaywall in
                    if isNeedToPresentPaywall {
                        navigateToPaywall = true
                    }
                })
            )
        }
    }
    
    private func getBackgroundColor() -> Color {
        switch viewModel.viewState {
        case .noPassword:
            return Color.white
        case .containsPasswords(_):
            return ColorManager.backgroundOverlayColor.color
        }
    }
}

#Preview {
    PasswordVaultScreen()
}

struct PasswordItemView: View {
    
    @State private var isPasswordVisible = false
    @State private var isSheetPresented = false

    let item: PasswordItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: "\(item.domainName)")) { image in
                    image.resizable()
                    image.aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image(systemName: "lock.fill")
                         .resizable()
                         .aspectRatio(contentMode: .fit)

                }
                .frame(width: 24, height: 24)
                
                Text(item.domainName)
                    .foregroundColor(ColorManager.textDefaultColor.color)
                    .font(.custom(FontsManager.SFSemibold.font, size: 18))
                    .lineLimit(1)
                
                Spacer()
                Button(action: {
                    isSheetPresented = true
                }) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .foregroundColor(.black)
                        
                }
            }
            .padding(.bottom, 16)
            
            HStack(spacing: 18) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username:")
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFRegular.font, size: 12))
                    Text("\(item.username)")
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFbold.font, size: 14))
                        .lineLimit(1)
                }
                .frame(maxWidth: 160)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password:")
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFRegular.font, size: 12))
                    HStack {
                        Text(isPasswordVisible ? "\(item.password)" : "••••••••••••••")
                            .foregroundColor(ColorManager.textDefaultColor.color)
                            .font(.custom(FontsManager.SFbold.font, size: 14))
                            .lineLimit(1)
                            
                        Spacer()

                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .frame(height: 126)
        .background(Color.white)
        .cornerRadius(16)
        .sheet(isPresented: $isSheetPresented) {
            ActionSheetView(item: item)
                .presentationDetents([.height(448)]) 
                .presentationDragIndicator(.visible)
                .background(ColorManager.actionSheetColor.color)
        }
    }
 }


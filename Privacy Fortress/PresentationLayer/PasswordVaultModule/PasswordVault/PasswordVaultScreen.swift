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
    @State private var showToast = false
    @State private var selectedItem: PasswordItem?
    @State private var isNeedToPresetDeleteAlert = false
    @State private var isEditingPassword = false

    private let columns = [
        GridItem(.flexible(), spacing: 1.5),
    ]

    var body: some View {
            GeometryReader { geometry in
                VStack {
                    ScrollView {
                        VStack {
                            switch viewModel.viewState {
                            case .noPassword:
                                noPasswordsView()
                            case .containsPasswords(let passwords):
                                ForEach(passwords) { item in
                                    PasswordItemCellView(onCopy: {
                                        showToastMessage()
                                    }, onDelete: { onDeleteSelectedItem in
                                        selectedItem = onDeleteSelectedItem
                                        isNeedToPresetDeleteAlert = true
                                    }, onEdit: { onEditSelectedItem in
                                        selectedItem = onEditSelectedItem
                                        isEditingPassword = true
                                    }, item: item)
                                        .frame(maxWidth: .infinity)
                                }
                                .padding(.top, 20)
                            }
                        }
                        .frame(minHeight: geometry.size.height, alignment: .top)
                    }
                    
                    Spacer()
                    
                    VStack {
                        if showToast {
                            toastView()
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                        
                        savePasswordButton()
                    }
                    .padding(.bottom, 24)
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
                viewModel.loadPasswords()
            }
            
            .navigationDestination(isPresented: $navigateToPaywall) {
                PaywallScreen()
            }
            
            .navigationDestination(isPresented: $isEditingPassword) {
                Group {
                    if let selectedItem {
                        AddPasswordScreen(passwordItem: selectedItem)
                    } else {
                        EmptyView()
                    }
                }
            }
            
            .overlay(
                SubscriptionAlertView(isPresented: $viewModel.isNeedToPresentSubscriptionAlert, onDismiss: { isNeedToPresentPaywall in
                    if isNeedToPresentPaywall {
                        navigateToPaywall = true
                    }
                })
            )
            
            .overlay(
                Group {
                    DeleteItemAlert(isPresented: $isNeedToPresetDeleteAlert, onDismiss: { isNeedToDelete in
                        if isNeedToDelete, let selectedItem = selectedItem {
                            let isDeleted = KeychainWrapperManager.shared.deletePasswordItem(forDomain: selectedItem.domain)
                            if isDeleted {
                                viewModel.loadPasswords()
                            }
                        }
                    })
                }
            )
    }
    
    private func savePasswordButton() -> some View {
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
    
    private func noPasswordsView() -> some View {
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
    }
    
    @ViewBuilder
    private func toastView() -> some View {
        VStack(alignment: .leading) {
            Text("Copied value to the clipboard")
                .padding(.bottom, 3)
            Text("• • • • • • • • • • ")
        }
        .frame(height: 64)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .foregroundColor(ColorManager.textDefaultColor.color)
        .font(.custom(FontsManager.SFRegular.font, size: 14))
        .cornerRadius(14)
        .padding(.bottom, 8)
    }
    
    private func getBackgroundColor() -> Color {
        switch viewModel.viewState {
        case .noPassword:
            return Color.white
        case .containsPasswords(_):
            return ColorManager.backgroundOverlayColor.color
        }
    }
    
    private func showToastMessage() {
        withAnimation {
            showToast = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showToast = false
            }
        }
    }
}

#Preview {
    PasswordVaultScreen()
}



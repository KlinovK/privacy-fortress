//
//  DataProtectionScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import SwiftUI

struct DataProtectionScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: DataProtectionViewModel
    
    let passcodeLength = 6
    
    init(entryPoint: DataProtectionEntryPoint) {
        _viewModel = StateObject(wrappedValue: DataProtectionViewModel(entryPoint: entryPoint))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                passcodeTitleSection()
                passcodeIndicator()
                keypadGrid()
            }
            .navigationTitle(viewModel.titleText)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorManager.mainBackground.color)
            .onAppear(perform: viewModel.onViewAppear)
            
            .overlay(
                alertsOverlay()
            )
            .onChange(of: viewModel.passcodeViewState) { newState in
                viewModel.onPasscodeViewStateChange(newState: newState)
            }
            
            .onChange(of: viewModel.isNeedToDismiss, perform: { isNeedToDismiss in
                dismiss()
            })
            
            .navigationDestination(isPresented: $viewModel.isNeedToPresentNextDestination) {
                destinationView()
            }
        }
        
    }

    
    @ViewBuilder
    private func alertsOverlay() -> some View {
        Group {
            if viewModel.isNeedToShowPasscodeIsNotEqualsAlert {
                DataProtectionPasscodesDoNotMatchAlert(
                    isPresented: $viewModel.isNeedToShowPasscodeIsNotEqualsAlert,
                    onDismiss: viewModel.executeTryAgainAction
                )
            }
            if viewModel.isNeedToShowInfoAlert {
                DataProtectionInfoAlert(isPresented: $viewModel.isNeedToShowInfoAlert)
            }
            if viewModel.isNeedToSetUpBiometricAuthentication {
                BiometricAlert(isPresented: $viewModel.isNeedToSetUpBiometricAuthentication, onDismiss: { isNeedToSetUpBiometricAuthentication in
                    
                    if isNeedToSetUpBiometricAuthentication {
                        viewModel.authenticateWithBiometrics()
                    } else {
                        if viewModel.dataProtectionEntryPoint == .settings {
                            dismiss()
                        } else {
                            viewModel.isNeedToPresentNextDestination = true
                        }
                    }
                    
                })
            }
        }
    }
    
    @ViewBuilder
    private func keypadGrid() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
            ForEach(1...9, id: \.self) { number in
                keypadButton("\(number)")
            }
            
            Spacer()
            keypadButton("0")
            deleteButton()
        }
    }
    
    private func keypadButton(_ number: String) -> some View {
        Button(action: { viewModel.addNumber(number) }) {
            Text(number)
                .frame(width: 96, height: 96)
                .background(Color.black.opacity(0.03))
                .clipShape(Circle())
                .font(.custom(FontsManager.SFbold.font, size: 35))
                .foregroundColor(ColorManager.buttonActiveColor.color)
        }
    }
    
    private func deleteButton() -> some View {
        Button(action: { viewModel.deleteLastDigit() }) {
            Image(systemName: "delete.left")
                .frame(width: 96, height: 96)
                .background(Color.black.opacity(0.03))
                .clipShape(Circle())
                .font(.custom(FontsManager.SFbold.font, size: 35))
                .foregroundColor(ColorManager.buttonActiveColor.color)
        }
    }
    
    @ViewBuilder
    private func passcodeIndicator() -> some View {
        HStack(spacing: 10) {
            ForEach(0..<passcodeLength, id: \.self) { index in
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(index < viewModel.enteredPasscodeCount() ? ColorManager.buttonActiveColor.color : ColorManager.backgroundOverlayColor.color)
                    .overlay(Circle().stroke(Color.green, lineWidth: 2))
            }
        }
        .padding(.bottom, 40)
    }
    
    @ViewBuilder
    private func passcodeTitleSection() -> some View {
        Text(viewModel.screenTitle)
            .font(.custom(FontsManager.SFbold.font, size: 24))
            .foregroundColor(ColorManager.textDefaultColor.color)
            .hidden(viewModel.screenHeaderIsHidden)
        
        Text(viewModel.screenSubTitle)
            .font(.custom(FontsManager.SFRegular.font, size: 17))
            .foregroundColor(ColorManager.textDefaultColor.color)
            .padding(.bottom, 14)
            .hidden(viewModel.screenSubtitleIsHidden)
    }
    
    // MARK: - Navigation
    
    @ViewBuilder
    private func destinationView() -> some View {
        switch viewModel.navigationLinkNextDestination {
        case .mediaSafe:
            MediaSafeScreen()
        case .passwordVault:
            PasswordVaultScreen()
        case .settings:
            EmptyView()
        }
    }
}

#Preview {
    DataProtectionScreen(entryPoint: .passwordVault)
}

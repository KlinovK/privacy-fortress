//
//  BiometricAlert.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 04/03/25.
//

import SwiftUI
import LocalAuthentication

struct BiometricAlert: View {
    
    @Binding var isPresented: Bool
    @State private var scaleEffect: CGFloat = 0.8
    @State private var opacity: Double = 0.0
    
    var onDismiss: ((Bool) -> Void)?

    var body: some View {
        ZStack {
            if isPresented {
                Color.black.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresented = false
                    }

                VStack(spacing: 0) {
                    Image(systemName: createAlertImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 44)
                        .padding(.bottom, 15)
                        .foregroundColor(ColorManager.buttonActiveColor.color)

                    Text("Do you want to enable")
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFbold.font, size: 17))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 4)
                    
                    Text(getAlertSubtitle())
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFRegular.font, size: 13))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 21)

                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(Color.gray)
                            .opacity(0.5)
                            .frame(height: 1)
                        HStack {
                            yesButton()
                            noButton()
                        }
                        .frame(height:44)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 19)
                .background(ColorManager.mainBackground.color)
                .cornerRadius(14)
                .shadow(radius: 1)
                .frame(maxWidth: 270)
                .scaleEffect(scaleEffect)
                .opacity(opacity)
                .animation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0), value: isPresented)
                .onAppear {
                    withAnimation {
                        scaleEffect = 1.0
                        opacity = 1.0
                    }
                }
                .onDisappear {
                    withAnimation {
                        scaleEffect = 0.8
                        opacity = 0.0
                    }
                }
            }
        }
        
    }
    
    private func closeAlert(isNeedToSetupBiometric: Bool = false) {
        withAnimation {
            scaleEffect = 0.8
            opacity = 0.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
            onDismiss?(isNeedToSetupBiometric)
        }
    }
    
    private func getAvailableBiometricType() -> LABiometryType {
        let context = LAContext()
        _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return context.biometryType
    }
    
    private func createAlertImage() -> String {
        switch getAvailableBiometricType() {
        case .touchID:
            return "touchid"
        case .faceID:
            return "faceid"
        case .opticID:
            return "opticid"
        case .none:
            return "lock.fill"
        @unknown default:
            return "lock.fill"
        }
        
    }
    
    private func getAlertSubtitle() -> String {
        switch getAvailableBiometricType() {
        case .touchID:
            return "Touch ID for quick access to your Media Safe and Password Vault?"
        case .faceID:
            return "Face ID for quick access to your Media Safe and Password Vault?"
        case .opticID:
            return "Optic ID for quick access to your Media Safe and Password Vault?"
        case .none:
            return "No access to your Media Safe and Password Vault?"
        @unknown default:
            return "No access to your Media Safe and Password Vault?"
        }
    }
    
    private func yesButton() -> some View {
        Button(action: {
            closeAlert(isNeedToSetupBiometric: true)
        }) {
            Text("Yes")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(ColorManager.textBlueColor.color)
                .cornerRadius(8)
                .font(.custom(FontsManager.SFbold.font, size: 17))
        }
    }
    
    private func noButton() -> some View {
        Button(action: {
            closeAlert()
        }) {
            Text("No")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(ColorManager.warningTextColor.color)
                .cornerRadius(8)
                .font(.custom(FontsManager.SFRegular.font, size: 17))
        }
    }
    
}

#Preview {
    BiometricAlert(isPresented: .constant(true))
}

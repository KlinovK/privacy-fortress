//
//  GenerateNewPasswordAlert.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 10/03/25.
//

import SwiftUI

struct GenerateNewPasswordAlert: View {
    
    @Binding var isPresented: Bool
    
    @State private var scaleEffect: CGFloat = 0.8
    @State private var opacity: Double = 0.0
    var onDismiss: ((String) -> Void)?
    let newPassword: String?

    var body: some View {
        ZStack {
            if isPresented {
                Color.black.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresented = false
                    }

                VStack(spacing: 0) {
                    
                    Text("We've generated a secure password for you")
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFbold.font, size: 17))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 16)
                    Text(newPassword ?? "")
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFbold.font, size: 16))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(ColorManager.textFieldBorderColor.color, lineWidth: 1)
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 17)

                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(Color.gray)
                            .opacity(0.5)
                            .frame(height: 1)
                        Button(action: {
                            closeAlert(newPassword: newPassword ?? "")
                        }) {
                            Text("Use this password")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(ColorManager.textBlueColor.color)
                                .cornerRadius(8)
                                .font(.custom(FontsManager.SFSemibold.font, size: 17))
                        }
                        .frame(height:44)
                        Rectangle()
                            .foregroundColor(Color.gray)
                            .opacity(0.5)
                            .frame(height: 1)
                        Button(action: {
                            closeAlert()
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(ColorManager.textBlueColor.color)
                                .cornerRadius(8)
                                .font(.custom(FontsManager.SFRegular.font, size: 17))
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
    
    private func closeAlert(newPassword: String? = nil) {
        withAnimation {
            scaleEffect = 0.8
            opacity = 0.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
            onDismiss?(newPassword ?? "")
        }
    }
}

#Preview {
    GenerateNewPasswordAlert(isPresented: .constant(true), newPassword: "asufyddsft78sdfsdasdhusdh")
}

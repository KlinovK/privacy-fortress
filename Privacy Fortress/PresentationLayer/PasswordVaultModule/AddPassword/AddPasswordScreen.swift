//
//  AddPasswordScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 09/03/25.
//

import SwiftUI

struct AddPasswordScreen: View {
    
    @Environment(\.dismiss) private var dismiss

    var passwordItem: PasswordItem?

    @State private var domainName: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var generatedPassword: String = ""
    @State private var isNeedToPresentGeneratedPasswordAlert: Bool = false

    init(passwordItem: PasswordItem? = nil) {
        self.passwordItem = passwordItem
        _domainName = State(initialValue: passwordItem?.domain ?? "")
        _username = State(initialValue: passwordItem?.username ?? "")
        _password = State(initialValue: passwordItem?.password ?? "")
    }

    var body: some View {
            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Enter Domain or App name")
                        .font(.custom(FontsManager.SFSemibold.font, size: 18))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    TextField("Enter domain", text: $domainName)
                        .padding()
                        .frame(height: 48)
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFSemibold.font, size: 18))
                        .autocapitalization(.none)
                        .textContentType(.URL)
                        .keyboardType(.URL)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(ColorManager.textFieldBorderColor.color, lineWidth: 1)
                        )
                }
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(.custom(FontsManager.SFSemibold.font, size: 18))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    TextField("Enter username", text: $username)
                        .padding()
                        .frame(height: 48)
                        .autocapitalization(.none)
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFSemibold.font, size: 18))
                        .textContentType(.username)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(ColorManager.textFieldBorderColor.color, lineWidth: 1)
                        )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.custom(FontsManager.SFSemibold.font, size: 18))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    HStack(spacing: 12) {
                        ZStack(alignment: .trailing) {
                            if isPasswordVisible {
                                TextField("Enter password", text: $password)
                                    .padding()
                                    .frame(height: 48)
                                    .autocapitalization(.none)
                                    .foregroundColor(ColorManager.textDefaultColor.color)
                                    .font(.custom(FontsManager.SFSemibold.font, size: 18))
                                    .textContentType(.password)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(ColorManager.textFieldBorderColor.color, lineWidth: 1)
                                    )
                            } else {
                                SecureField("Enter password", text: $password)
                                    .padding()
                                    .frame(height: 48)
                                    .autocapitalization(.none)
                                    .textContentType(.password)
                                    .background(Color.white)
                                    .foregroundColor(ColorManager.textDefaultColor.color)
                                    .font(.custom(FontsManager.SFSemibold.font, size: 18))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(ColorManager.textFieldBorderColor.color, lineWidth: 1)
                                    )
                            }
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                                    .padding(.trailing, 10)
                            }
                            .background(Color.white)
                            
                        }
                        

                        Button(action: {
                            generatedPassword = generateRandomPassword(length: 12)
                            isNeedToPresentGeneratedPasswordAlert = true
                        }) {
                            Image(systemName: "sparkles")
                                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                                .padding()
                        }
                        .background(Color.white)
                        .frame(width: 48, height: 48)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(ColorManager.textFieldBorderColor.color, lineWidth: 1)
                        )
                    }
                }

                Spacer()

                Button(action: savePassword) {
                    Text("Save Password")
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(ColorManager.buttonActiveColor.color)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 20)
            .padding(.top, Constants.isIPad ? 20 : 20)
            .padding(.horizontal, Constants.isIPad ? 190 : 24)
            .background(ColorManager.mainBackground.color)
            .navigationTitle("New Password")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        savePassword()
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        
            .onAppear(perform: {
                _ = KeychainWrapperManager.shared.deletePasswordItem(forDomain: domainName)
            })
        
            .overlay(
                GenerateNewPasswordAlert(isPresented: $isNeedToPresentGeneratedPasswordAlert, onDismiss: { newPassword in
                    if newPassword != "" {
                        password = newPassword
                    }
                }, newPassword: generatedPassword)
            )
    }
    
    private func savePassword() {
        let isPasswordItemWasSaved = KeychainWrapperManager.shared.savePasswordItem(PasswordItem(domain: domainName, username: username, password: password))
        if isPasswordItemWasSaved {
            dismiss()
        } else {
            print("Password item wasn't saved")
        }
    }
    
    private func generateRandomPassword(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{}|;:'\",.<>?/~"
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
}

#Preview {
    AddPasswordScreen()
}

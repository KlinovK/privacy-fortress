//
//  AddPasswordScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 09/03/25.
//

import SwiftUI

struct AddPasswordScreen: View {
    
    @Environment(\.dismiss) private var dismiss

    @State private var domainName: String = ""
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Enter Domain or App name")
                        .font(.custom(FontsManager.SFSemibold.font, size: 18))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    TextField("Enter domain", text: $domainName)
                        .autocapitalization(.none)
                        .textContentType(.URL)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 48)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(.custom(FontsManager.SFSemibold.font, size: 18))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    TextField("Enter username", text: $username)
                        .autocapitalization(.none)
                        .textContentType(.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 48)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.custom(FontsManager.SFSemibold.font, size: 18))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    HStack {
                        SecureField("Enter password", text: $password)
                            .textContentType(.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(height: 48)

                        Button(action: {
                            // Add your button action here
                            print("Button tapped")
                        }) {
                            Image(systemName: "eye.fill") // Example icon for showing password
                                .foregroundColor(.gray)
                                .padding()
                        }
                        .background(Color.white)
                        .frame(width: 48, height: 48)
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
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
    
    private func savePassword() {
        // Save to keychain or any storage logic
        print("Saving password for \(domainName)")
    }
}

#Preview {
    AddPasswordScreen()
}

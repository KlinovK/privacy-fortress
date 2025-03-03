//
//  DataProtectionScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import SwiftUI

struct DataProtectionScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var enteredPasscode = ""
    @State private var repeatedPasscode = ""
    @State private var isNeedToShowPasscodeIsNotEqualsAlert = false
    @State private var isNeedToShowInfoAlert = false
    @State private var passcodeViewState: PasscodeViewState = KeychainWrapperManager.shared.getValue(forKey: Constants.KeychainConstants.kPasscodeKeychainKey) != nil ? .enterPasscode : .setUp
    @State private var attemptCount: Int = 0
    
    let dataProtectionEntryPoint: DataProtectionEntryPoint
    let correctPasscode: String
    let onUnlock: () -> Void

    let passcodeLength = 6

    var body: some View {
        VStack(spacing: 0) {
            Text(screenTitle)
                .font(.custom(FontsManager.SFbold.font, size: 24))
                .foregroundColor(ColorManager.textDefaultColor.color)
                .hidden(getScreenHeaderIsHiddenState())
            Text(screenSubTitle)
                .font(.custom(FontsManager.SFRegular.font, size: 17))
                .foregroundColor(ColorManager.textDefaultColor.color)
                .padding(.bottom, 14)
                .hidden(getScreenSubtitleIsHiddenState())
            HStack(spacing: 10) {
                ForEach(0..<passcodeLength, id: \.self) { index in
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(index < enteredPasscodeCount() ? ColorManager.buttonActiveColor.color : ColorManager.backgroundOverlayColor.color)
                        .overlay(
                            Circle()
                                .stroke(Color.green, lineWidth: 2)
                        )
                }
            }

            .padding(.bottom, 40)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                ForEach(1...9, id: \.self) { number in
                    Button(action: {
                        addNumber("\(number)")
                    }) {
                        Text("\(number)")
                            .frame(width: 96, height: 96)
                            .background(Color.black.opacity(0.03))
                            .clipShape(Circle())
                            .font(.custom(FontsManager.SFbold.font, size: 35))
                            .foregroundColor(ColorManager.buttonActiveColor.color)
                    }
                }

                Spacer()
                
                Button(action: {
                    addNumber("0")
                }) {
                    Text("0")
                        .frame(width: 96, height: 96)
                        .background(Color.black.opacity(0.03))
                        .clipShape(Circle())
                        .font(.custom(FontsManager.SFbold.font, size: 35))
                        .foregroundColor(ColorManager.buttonActiveColor.color)
                }


                Button(action: {
                    deleteLastDigit()
                }) {
                    Image(systemName: "delete.left")
                        .frame(width: 96, height: 96)
                        .background(Color.black.opacity(0.03))
                        .clipShape(Circle())
                        .font(.custom(FontsManager.SFbold.font, size: 35))
                        .foregroundColor(ColorManager.buttonActiveColor.color)
                }

            }
        }
        .navigationTitle(titleText)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorManager.mainBackground.color)

        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if passcodeViewState == .setUp {
                    isNeedToShowInfoAlert = true
                }
            }
        })
        
        .overlay(
            Group {
                if isNeedToShowPasscodeIsNotEqualsAlert {
                    DataProtectionPasscodesDoNotMatchAlert(isPresented: $isNeedToShowPasscodeIsNotEqualsAlert, onDismiss: {
                        executeTryAgainAction()
                    })
                }
#warning("uncomment this line to show info alert")
//                if isNeedToShowInfoAlert {
//                    DataProtectionInfoAlert(isPresented: $isNeedToShowInfoAlert)
//                }
            }
        )
    }
    
    private func enteredPasscodeCount() -> Int {
        switch passcodeViewState {
        case .setUp:
            return enteredPasscode.count
        case .repeatPasscode:
            return repeatedPasscode.count
        case .enterPasscode:
            return enteredPasscode.count
        case .tooManyAttempts:
            return 0
        }
    }

    private func addNumber(_ number: String) {
        
        switch passcodeViewState {
        case .setUp:
            if enteredPasscode.count < passcodeLength {
                enteredPasscode.append(number)
            }
            if enteredPasscode.count == passcodeLength {
                passcodeViewState = .repeatPasscode
            }
        case .repeatPasscode:
            if repeatedPasscode.count < passcodeLength {
                repeatedPasscode.append(number)
            }
            
            if repeatedPasscode.count == passcodeLength && enteredPasscode.count == passcodeLength {
                if isPasscodesEqual() {
                    KeychainWrapperManager.shared.setSecure(value: enteredPasscode, forKey: Constants.KeychainConstants.kPasscodeKeychainKey)
//                    presenfaceid/touchid
                    
                } else {
                    isNeedToShowPasscodeIsNotEqualsAlert = true
                }
            }
        case .enterPasscode:
            return
        case .tooManyAttempts:
            return
        }
    }

    private func deleteLastDigit() {
        if !enteredPasscode.isEmpty {
            enteredPasscode.removeLast()
        }
    }
    
    private func isPasscodesEqual() -> Bool {
        return enteredPasscode == repeatedPasscode
    }

    private func checkPasscode() {
        if enteredPasscode == correctPasscode {
            onUnlock()
        } else {
//            showError = true
            enteredPasscode = ""
        }
    }
    
    private func executeTryAgainAction() {
        passcodeViewState = .setUp
        enteredPasscode = ""
        repeatedPasscode = ""
        attemptCount += 1
        
        if attemptCount >= 3 {
            passcodeViewState = .tooManyAttempts
        }
    }
    
    private var titleText: String {
        switch dataProtectionEntryPoint {
        case .mediaSafe:
            return "Media Safe"
        case .passwordVault:
            return "Password Vault"
        }
    }
    
    private var screenTitle: String {
        switch passcodeViewState {
        case .setUp:
            return "Set Up Passcode"
        case .repeatPasscode:
            return "Repeat Password"
        case .enterPasscode:
            return "Enter your password"
        case .tooManyAttempts:
            return "Repeat Password"
        }
    }
    
    private var screenSubTitle: String {
        switch passcodeViewState {
        case .setUp:
            return "You'll need it to access the \(titleText)"
        case .repeatPasscode:
            return "You'll need it to access the \(titleText)"
        case .enterPasscode:
            return ""
        case .tooManyAttempts:
            return "Too many failed attempts. Try again later"
        }
    }
    
    private func getScreenHeaderIsHiddenState() -> Bool {
        if passcodeViewState == .tooManyAttempts {
            return true
        } else {
            return false
        }
    }
    
    private func getScreenSubtitleIsHiddenState() -> Bool {
        if passcodeViewState == .enterPasscode {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    DataProtectionScreen(dataProtectionEntryPoint: .mediaSafe, correctPasscode: "", onUnlock: {})
}

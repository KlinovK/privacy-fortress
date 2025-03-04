//
//  DataProtectionViewModel.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 04/03/25.
//

import Foundation
import LocalAuthentication

class DataProtectionViewModel: ObservableObject {
    
    @Published var enteredPasscode = ""
    @Published var repeatedPasscode = ""
    @Published var isNeedToShowPasscodeIsNotEqualsAlert = false
    @Published var isNeedToShowInfoAlert = false
    @Published var isNeedToSetUpBiometricAuthentication = false
    @Published var isNeedToPresentNextDestination = false
    @Published var passcodeViewState: PasscodeViewState
    @Published var attemptCount = 0
    @Published var remainingSeconds = 30
    
    private var timer: Timer?
    private let passcodeLength = 6
    private let dataProtectionEntryPoint: DataProtectionEntryPoint
    private let keychainKey = Constants.KeychainConstants.kPasscodeKeychainKey
    
    init(entryPoint: DataProtectionEntryPoint) {
        self.dataProtectionEntryPoint = entryPoint
        self.passcodeViewState = KeychainWrapperManager.shared.getValue(forKey: keychainKey) != nil ? .enterPasscode : .setUp
    }
    
    // MARK: - Public Methods
    
    func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isNeedToPresentNextDestination = true
                    } else {
                        print("Biometric authentication failed: \(authenticationError?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        } else {
            print("Biometric authentication not available")
        }
    }
    
    func addNumber(_ number: String) {
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
                    KeychainWrapperManager.shared.setSecure(value: enteredPasscode, forKey: keychainKey)
                    isNeedToSetUpBiometricAuthentication = true
                } else {
                    isNeedToShowPasscodeIsNotEqualsAlert = true
                }
            }
        case .enterPasscode:
            if enteredPasscode.count < passcodeLength {
                enteredPasscode.append(number)
            }
            if enteredPasscode.count == passcodeLength {
                checkPasscode()
            }
        case .tooManyAttempts:
            break
        }
    }
    
    func deleteLastDigit() {
        switch passcodeViewState {
        case .setUp:
            if !enteredPasscode.isEmpty {
                enteredPasscode.removeLast()
            }
        case .repeatPasscode:
            if !repeatedPasscode.isEmpty {
                repeatedPasscode.removeLast()
            }
        case .enterPasscode:
            if !enteredPasscode.isEmpty {
                enteredPasscode.removeLast()
            }
        case .tooManyAttempts:
            if !enteredPasscode.isEmpty {
                enteredPasscode.removeLast()
            }
        }
    }

    func enteredPasscodeCount() -> Int {
        switch passcodeViewState {
        case .setUp: return enteredPasscode.count
        case .repeatPasscode: return repeatedPasscode.count
        case .enterPasscode: return enteredPasscode.count
        case .tooManyAttempts: return 0
        }
    }
    
    func executeTryAgainAction() {
        passcodeViewState = .setUp
        enteredPasscode = ""
        repeatedPasscode = ""
        attemptCount += 1
        
        if attemptCount >= 3 {
            passcodeViewState = .tooManyAttempts
        }
    }
    
    func onViewAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.passcodeViewState == .setUp {
                self.isNeedToShowInfoAlert = true
            }
        }
        if passcodeViewState == .tooManyAttempts {
            startTimer()
        }
        
        if passcodeViewState == .enterPasscode {
            authenticateWithBiometrics()
        }
    }
    
    func onPasscodeViewStateChange(newState: PasscodeViewState) {
        if newState == .tooManyAttempts {
            remainingSeconds = 30
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    // MARK: - Computed Properties
    
    var navigationLinkNextDestination: DataProtectionEntryPoint {
        return dataProtectionEntryPoint
    }
    
    var titleText: String {
        switch dataProtectionEntryPoint {
        case .mediaSafe: return "Media Safe"
        case .passwordVault: return "Password Vault"
        }
    }
    
    var screenTitle: String {
        switch passcodeViewState {
        case .setUp: return "Set Up Passcode"
        case .repeatPasscode: return "Repeat Password"
        case .enterPasscode: return "Enter your password"
        case .tooManyAttempts: return "Repeat Password"
        }
    }
    
    var screenSubTitle: String {
        switch passcodeViewState {
        case .setUp: return "You'll need it to access the \(titleText)"
        case .repeatPasscode: return "You'll need it to access the \(titleText)"
        case .enterPasscode: return ""
        case .tooManyAttempts: return "Too many failed attempts. Try again in \(remainingSeconds) seconds"
        }
    }
    
    var screenHeaderIsHidden: Bool {
        passcodeViewState == .tooManyAttempts
    }
    
    var screenSubtitleIsHidden: Bool {
        passcodeViewState == .enterPasscode
    }
    
    // MARK: - Private Methods
    
    private func isPasscodesEqual() -> Bool {
        enteredPasscode == repeatedPasscode
    }
    
    private func checkPasscode() {
        if enteredPasscode == KeychainWrapperManager.shared.getValue(forKey: keychainKey) {
            isNeedToPresentNextDestination = true
        } else {
            enteredPasscode = ""
            attemptCount += 1
            if attemptCount >= 3 {
                passcodeViewState = .tooManyAttempts
            }
        }
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
            } else {
                self.stopTimer()
                self.resetToSetupState()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func resetToSetupState() {
        passcodeViewState = KeychainWrapperManager.shared.getValue(forKey: keychainKey) != nil ? .enterPasscode : .setUp
        enteredPasscode = ""
        repeatedPasscode = ""
        attemptCount = 0
        remainingSeconds = 30
    }
}

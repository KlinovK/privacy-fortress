//
//  DataProtectionScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import SwiftUI

struct DataProtectionScreen: View {
    
    let dataProtection: DataProtectionEntryPoint

    @State private var enteredPasscode = ""
    @State private var showError = false
    let correctPasscode: String
    let onUnlock: () -> Void

    let passcodeLength = 4 // Set the length of the passcode

    var body: some View {
        VStack {
            Text("Enter Passcode")
                .font(.title)
                .padding()

            HStack {
                ForEach(0..<passcodeLength, id: \.self) { index in
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(index < enteredPasscode.count ? .blue : .gray)
                }
            }
            .padding()

            if showError {
                Text("Incorrect passcode. Try again.")
                    .foregroundColor(.red)
                    .padding(.bottom, 10)
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                ForEach(1...9, id: \.self) { number in
                    Button(action: {
                        addNumber("\(number)")
                    }) {
                        Text("\(number)")
                            .font(.largeTitle)
                            .frame(width: 60, height: 60)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }

                Spacer()

                Button(action: {
                    deleteLastDigit()
                }) {
                    Image(systemName: "delete.left.fill")
                        .font(.largeTitle)
                        .frame(width: 60, height: 60)
                        .background(Color.red.opacity(0.2))
                        .clipShape(Circle())
                }

                Button(action: {
                    addNumber("0")
                }) {
                    Text("0")
                        .font(.largeTitle)
                        .frame(width: 60, height: 60)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }
            .padding(.top, 20)
        }
    }

    private func addNumber(_ number: String) {
        if enteredPasscode.count < passcodeLength {
            enteredPasscode.append(number)
        }
        if enteredPasscode.count == passcodeLength {
            checkPasscode()
        }
    }

    private func deleteLastDigit() {
        if !enteredPasscode.isEmpty {
            enteredPasscode.removeLast()
        }
    }

    private func checkPasscode() {
        if enteredPasscode == correctPasscode {
            onUnlock()
        } else {
            showError = true
            enteredPasscode = ""
        }
    }
}

#Preview {
    DataProtectionScreen(dataProtection: .mediaSafe, correctPasscode: "", onUnlock: {})
}

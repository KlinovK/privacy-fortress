//
//  PasswordVaultScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 04/03/25.
//

import SwiftUI

struct PasswordVaultScreen: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationTitle("Password Vault")
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
    }
}

#Preview {
    PasswordVaultScreen()
}

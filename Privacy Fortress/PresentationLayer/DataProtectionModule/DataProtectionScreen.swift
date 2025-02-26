//
//  DataProtectionScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import SwiftUI

struct DataProtectionScreen: View {
    
    let dataProtection: DataProtectionEntryPoint

    var body: some View {
        switch dataProtection {
        case .mediaSafe:
            Text("Media")
        case .passwordVault:
            Text("Vault")
        }
    }
}

#Preview {
    DataProtectionScreen(dataProtection: .mediaSafe)
}

//
//  PasswordVaultViewModel.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import Foundation
import SwiftUI

@MainActor
final class PasswordVaultViewModel: ObservableObject {
    
    @Published var viewState: ViewState = .noPassword
    @Published var isNeedToPresentSubscriptionAlert = false

    enum ViewState {
        case noPassword
        case containsPasswords([PasswordItem])
    }

    func loadPasswords() {
        let passwords = KeychainWrapperManager.shared.getAllPasswordItems()
        updateViewState(passwordItems: passwords)
    }
    
    func updateViewState(passwordItems: [PasswordItem]) {
        if !UserSessionManager.shared.isUserSubscribed && passwordItems.count > 3 {
            isNeedToPresentSubscriptionAlert = true
        } else {
            DispatchQueue.main.async {
                if passwordItems.isEmpty {
                    self.viewState = .noPassword
                } else {
                    self.viewState = .containsPasswords(passwordItems)
                }
            }
        }
    }
}

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
    
    // MARK: - Published Properties
    
    @Published var viewState: PasswordVaultViewState = .noPassword
    @Published var isNeedToPresentSubscriptionAlert = false

    public func updateViewState(passwordItems: [PasswordItem]) {
//        if passwordItems.count > 3 {
//            isNeedToPresentSubscriptionAlert = true
//        } else {
//            viewState = passwordItems.isEmpty ? .noPassword : .containsPasswords([PasswordItem(domainName: "www.google.com", username: "user@example.com", password: "••••••••")])
//
//        }
        viewState = .containsPasswords([PasswordItem(domainName: "https://www.google.com/", username: "user@example.com", password: "asmndnas2"), PasswordItem(domainName: "https://www.google.com/", username: "user@example.com", password: "asmndnas2")])
    }
}

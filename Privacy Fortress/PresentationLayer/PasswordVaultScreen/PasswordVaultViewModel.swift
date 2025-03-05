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
    @Published var isNeedToPresentLimitsAlert = false

    public func updateViewState(passwordItems: [PasswordItem]) {
        viewState = .noPassword
    }
}

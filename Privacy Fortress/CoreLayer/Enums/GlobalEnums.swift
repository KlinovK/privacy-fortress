//
//  GlobalEnums.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation

enum StartScreenViewState {
    case start
    case isAnalyzing
    case isFinishedAnalyzing
}

enum StartScreenIssueType {
    case wifiSecurity
    case personalDataProtection
    case systemSecurity
    case safeStorage
}

enum ResultsScreenViewState {
    case issuesNotFound
    case issuesFound
}

enum CheckIssueEntryPoint {
    case maliciousSitesProtection
    case wifiSecurityCheck
}

enum WifiCheckResultScreenViewState {
    case wifiIsSecure
    case wifiIsNotSecure
}

//
//  GlobalEnums.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation

enum PasscodeViewState {
    case setUp
    case repeatPasscode
    case enterPasscode
    case tooManyAttempts
}

enum DataProtectionEntryPoint {
    case mediaSafe
    case passwordVault
}

enum LeakCellType {
    case data
    case compromised
    case description
    case recommendations
}

enum DataBreachesCheckViewState {
    case checking
    case notDetected
}

enum TutorialCellType {
    case routerPassword
    case networkName
    case switchToWPA3
    case updateRouterFirmware
    case createGuestNetwork
    case disableWPS
    case avoidAccessingSensitiveData
    case useVPN
    case turnOffSharing
    case stickToSecureNetworks
    case disconnect
}

enum WiFiSecurityStatus {
    case secure
    case unsecured
    case unknown
}

enum DeviceLockViewState {
    case enabled
    case disabled
}

enum DeviceLockDetailsViewState {
    case iOS17Tutorial
    case defaultTutorial
}

enum StartScreenViewState {
    case start
    case isAnalyzing
    case isNoIssuesState
    case longTimeNoScan
}

enum SettingsCellType {
    case rateUs
    case shareApp
    case privacyPolicy
    case termsOfService
    case changePassword
    case subscriptions
}

enum GeneralIssueType {
    case wifiSecurity
    case personalDataProtection
    case systemSecurity
    case safeStorage
}

enum ResultsScreenViewState {
    case issuesNotFound
    case issuesFound
}

enum WifiCheckResultScreenViewState {
    case wifiIsSecure
    case wifiIsNotSecure
}

enum IssueType {
    case maliciousSitesProtection
    case wifiSecurityCheck
    case dataBreachMonitoring
    case findMy
    case deviceLock
    case iOSVersionCheck
    case mediaSafe
    case passwordVaul
}

enum BadgeType {
    case main
    case results
}

//
//  StartScreenViewModel.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation

@MainActor
class StartScreenViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var progress: Double = 0.0
    @Published var wifiSecurityProgress: Double = 0.0
    @Published var personalDataProtectionProgress: Double = 0.0
    @Published var systemSecurityProgress: Double = 0.0
    @Published var safeStorageProgress: Double = 0.0
    @Published var isRequestComplete = false
    
    let randomDelay = Double.random(in: 0.3...1.0)
    
    private let wiFiSecurityManager: WiFiSecurityManagerProtocol
    private let systemSecurityManager: SystemSecurityManagerProtocol
    private let safeStorageManager: SafeStorageManagerProtocol
    private let personalDataProtectionManager: PersonalDataProtectionManagerProtocol

    init(wiFiSecurityManager: WiFiSecurityManagerProtocol = WiFiSecurityManager(), systemSecurityManager: SystemSecurityManagerProtocol = SystemSecurityManager(), safeStorageManager: SafeStorageManagerProtocol = SafeStorageManager(), personalDataProtectionManager: PersonalDataProtectionManagerProtocol = PersonalDataProtectionManager()) {
        self.wiFiSecurityManager = WiFiSecurityManager()
        self.systemSecurityManager = SystemSecurityManager()
        self.safeStorageManager = SafeStorageManager()
        self.personalDataProtectionManager = PersonalDataProtectionManager()
    }

    func startWiFiSecurityCheck() async {
        isLoading = true
        isRequestComplete = false

        _ = await wiFiSecurityManager.isWifiSafe()
        wiFiSecurityManager.reloadContentBlocker()
        
        for i in 1...25 {
            try? await Task.sleep(nanoseconds: 100_000_000)
            progress = Double(i) / 100
            wifiSecurityProgress = Double(i) / 25.0
        }

        try? await Task.sleep(nanoseconds: UInt64(randomDelay * 100_000_000))

        isLoading = false
        isRequestComplete = true
        progress = 0.25
        wifiSecurityProgress = 1.0
    }
    
    func startPersonalDataProtectionCheck() async {
        isLoading = true
        isRequestComplete = false

        await personalDataProtectionManager.checkIsCloudAccountAvailableAndSaveToUserSessionManager()
        let _ = await personalDataProtectionManager.checkDataBreach(for: "", isItFirstLaunch: true)
        
        for i in 1...25 {
            try? await Task.sleep(nanoseconds: 100_000_000)
            progress = (Double(i) / 100) + 0.25
            personalDataProtectionProgress = Double(i) / 25.0
        }

        try? await Task.sleep(nanoseconds: UInt64(randomDelay * 100_000_000))

        isLoading = false
        isRequestComplete = true
        progress = 0.5
        personalDataProtectionProgress = 1.0
    }
    
    func startSystemSecurityCheck() async {
        isLoading = true
        isRequestComplete = false

        await systemSecurityManager.saveIsDeviceLockStatusResult()
        await systemSecurityManager.saveDeviceVersionCheckResult()
        
        for i in 1...25 {
            try? await Task.sleep(nanoseconds: 100_000_000)
            progress = (Double(i) / 100) + 0.5
            systemSecurityProgress = Double(i) / 25.0
        }

        try? await Task.sleep(nanoseconds: UInt64(randomDelay * 100_000_000))

        isLoading = false
        isRequestComplete = true
        progress = 0.75
        systemSecurityProgress = 1.0
    }
    
    func startSafeStorageCheck() async {
        isLoading = true
        isRequestComplete = false
        
        await safeStorageManager.checkAndSaveIsAnyPasswordsSavedToSafeStorage()

        for i in 1...25 {
            try? await Task.sleep(nanoseconds: 100_000_000)
            progress = (Double(i) / 100) + 0.75
            safeStorageProgress = Double(i) / 25.0
        }

        try? await Task.sleep(nanoseconds: UInt64(randomDelay * 100_000_000))

        isLoading = false
        isRequestComplete = true
        progress = 1.0
        safeStorageProgress = 1.0
    }
}



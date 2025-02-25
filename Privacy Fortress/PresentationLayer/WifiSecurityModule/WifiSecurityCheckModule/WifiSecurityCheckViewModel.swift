//
//  WifiSecurityCheckViewModel.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 24/02/25.
//

import Foundation

@MainActor
class WifiSecurityCheckViewModel: ObservableObject {
    
    private let wiFiSecurityManager: WiFiSecurityManagerProtocol
    
    init(wiFiSecurityManager: WiFiSecurityManagerProtocol = WiFiSecurityManager()) {
        self.wiFiSecurityManager = WiFiSecurityManager()
    }
    
    func startWiFiSecurityCheck() async -> Bool {
        let connectionIsSecure = await wiFiSecurityManager.checkSecureConnection()
        return connectionIsSecure
    }
    
}

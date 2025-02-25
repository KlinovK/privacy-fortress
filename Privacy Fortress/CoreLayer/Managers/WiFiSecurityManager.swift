//
//  WiFiSecurityManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation
import Network
import SafariServices
import NetworkExtension

protocol WiFiSecurityManagerProtocol {
    func isWifiSafe() async -> Bool
    func reloadContentBlocker()
}

class WiFiSecurityManager: WiFiSecurityManagerProtocol {
            
    // MARK: - Methods
    
    public func isWifiSafe() async -> Bool {
        let captivePortalStatus = await checkForCaptivePortal()
        let wifiSecurityStatus = await checkWiFiSecurity()
        
        if captivePortalStatus == true || wifiSecurityStatus == .unsecured {
            UserSessionManager.shared.isSecureNetwork = false
            return false
        } else {
            UserSessionManager.shared.isSecureNetwork = true
            return true
        }
    }
    
    
    private func checkForCaptivePortal() async -> Bool {
        return await withCheckedContinuation { continuation in
            let monitor = NWPathMonitor()
            let queue = DispatchQueue(label: "NetworkMonitor")

            monitor.pathUpdateHandler = { path in
                if path.usesInterfaceType(.wifi) {
                    print("📡 Connected to Wi-Fi")
                    
                    if path.isExpensive {
                        print("⚠️ Possible Captive Portal Detected (Unsecured Wi-Fi)")
                        continuation.resume(returning: true)
                    } else {
                        print("✅ Likely a normal Wi-Fi network")
                        continuation.resume(returning: false)
                    }
                    
                    monitor.cancel()
                }
            }
            
            monitor.start(queue: queue)
        }
    }

    private func checkWiFiSecurity() async -> WiFiSecurityStatus {
        if let currentNetwork = await NEHotspotNetwork.fetchCurrent() {
            if currentNetwork.isSecure {
                print("✅ Connected to a secure Wi-Fi network")
                return .secure
            } else {
                print("⚠️ Connected to an **unsecured** Wi-Fi network")
                return .unsecured
            }
        } else {
            print("❌ Unable to retrieve Wi-Fi details. Ensure app has the required entitlements and permissions.")
            return .unknown
        }
    }
    
    public func reloadContentBlocker() {
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: Constants.contentBlockerIdentifier) { error in
            if let error = error {
                UserSessionManager.shared.isMaliciousSitesProtectionEnabled = false
                print("Error reloading content blocker: \(error.localizedDescription)")
            } else {
                UserSessionManager.shared.isMaliciousSitesProtectionEnabled = true
                print("✅ Content blocker reloaded successfully!")
            }
        }
    }
    
}


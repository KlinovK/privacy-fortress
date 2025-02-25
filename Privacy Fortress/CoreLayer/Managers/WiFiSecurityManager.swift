//
//  WiFiSecurityManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation
import Network
import SafariServices

protocol WiFiSecurityManagerProtocol {
    func checkSecureConnection() async -> Bool
    func checkNetworkType() async
    func reloadContentBlocker()
}

class WiFiSecurityManager: WiFiSecurityManagerProtocol {
            
    // MARK: - Methods
    
    public func checkSecureConnection() async -> Bool {
        let url = URL(string: "https://www.apple.com")!
        var request = URLRequest(url: url)
        request.timeoutInterval = 5

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("✅ Secure connection verified (Network allows HTTPS)")
                UserSessionManager.shared.isSecureNetwork = true
                return true
            } else {
                print("⚠️ Warning: Network might be insecure")
                UserSessionManager.shared.isSecureNetwork = false
                return false
            }
        } catch {
            print("❌ Error checking secure connection: \(error.localizedDescription)")
            UserSessionManager.shared.isSecureNetwork = false
            return false
        }
    }
    
    public func checkNetworkType() async {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            if path.usesInterfaceType(.wifi) {
                print("✅ Connected to Wi-Fi")
            } else if path.usesInterfaceType(.cellular) {
                print("📶 Using Cellular Data")
            }
        }
        
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
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


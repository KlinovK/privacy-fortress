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
    func checkSecureConnection() async
    func checkNetworkType() async
    func reloadContentBlocker()
}

class WiFiSecurityManager: WiFiSecurityManagerProtocol {
        
    // MARK: - Methods
    
    public func checkSecureConnection() async {
        let url = URL(string: "https://www.apple.com")!
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("✅ Secure connection verified (Network allows HTTPS)")
                UserSessionManager.shared.isSecureNetwork = true
            } else {
                UserSessionManager.shared.isSecureNetwork = false
                print("⚠️ Warning: Network might be insecure")
            }
        }.resume()
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


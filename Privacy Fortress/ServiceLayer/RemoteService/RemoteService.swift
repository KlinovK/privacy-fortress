//
//  RemoteService.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 01/03/25.
//

import Foundation
import UIKit
import AdSupport
import AppTrackingTransparency

protocol RemoteServiceProtocol {
    func sendFCMToken(_ token: String) async
    func sendUserData() async
}

final class RemoteService: RemoteServiceProtocol {
    
    public func sendUserData() async {
        let endpoint = "/apple/v2/user"
        var parameters: [String: Any] = await [
            "userId": UserSessionManager.shared.uniqueUserID,
            "timezone": getTimezoneOffset(),
            "locale": getLocale(),
            "os": UIDevice.current.systemVersion,
            "idfa": getIDFA(),
            "idfv": UIDevice.current.identifierForVendor?.uuidString ?? "00000000-0000-0000-0000-000000000000",
            "att": getATTStatus(),
            "region": Locale.current.region?.identifier ?? "Unknown",
            "currency": Locale.current.currency?.identifier ?? "Unknown",
            "screenSize": "\(UIScreen.main.bounds.width)x\(UIScreen.main.bounds.height)",
            "screenOrientation": getScreenOrientation(),
        ]
        
        if let transactionId = UserSessionManager.shared.originalTransactionID {
            parameters["originalTransactionId"] = transactionId
        }
        
        if let appflyerAttribution = UserSessionManager.shared.getAttributionData() as? [AnyHashable: Any],
           !appflyerAttribution.isEmpty {
            parameters["appflyerAttribution"] = appflyerAttribution
        }
        
        await sendRequest(endpoint: endpoint, parameters: parameters)
    }
    
    public func sendFCMToken(_ token: String) async {
        let endpoint = "/fcm"
        let parameters: [String: Any] = [
            "token": token,
            "timezone": getTimezoneOffset(),
            "locale": getLocale()
        ]
        
        await sendRequest(endpoint: endpoint, parameters: parameters)
    }
    
    private func sendRequest(endpoint: String, parameters: [String: Any]) async {
        guard let url = URL(string: Constants.apiBaseURL + endpoint) else {
            print("❌ Invalid URL")
            return
        }
        
        let headers: [String: String] = getHeaders()
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
            
            let (_, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("📡 HTTP Status: \(httpResponse.statusCode)")
            }
            
            print("✅ Successfully sent request to \(endpoint)")
        } catch {
            print("❌ Error sending request to \(endpoint): \(error)")
        }
    }
    
    private func getHeaders() -> [String: String] {
        return [
            "API-CLIENT-APP": Constants.clientApp,
            "API-CLIENT-ID": UserSessionManager.shared.uniqueUserID,
            "API-CLIENT-USER-AGENT": Constants.clientApp,
            "API-CLIENT-DEVICE-NAME": UIDevice.current.name
        ]
    }
    
    private func getTimezoneOffset() -> String {
        let secondsFromGMT = TimeZone.current.secondsFromGMT()
        let hours = secondsFromGMT / 3600
        let minutes = abs(secondsFromGMT % 3600) / 60
        return String(format: "%+02d:%02d", hours, minutes)
    }
    
    private func getLocale() -> String {
        return Locale.current.identifier
    }
    
    private func getIDFA() -> String {
        guard ATTrackingManager.trackingAuthorizationStatus == .authorized else {
            return "00000000-0000-0000-0000-000000000000"
        }
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    private func getATTStatus() -> Int {
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .notDetermined: return 0
        case .restricted: return 1
        case .denied: return 2
        case .authorized: return 3
        @unknown default: return -1
        }
    }
    
    private func getScreenOrientation() -> String {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .portrait, .portraitUpsideDown: return "Portrait"
        case .landscapeLeft, .landscapeRight: return "Landscape"
        default: return "Unknown"
        }
    }
}

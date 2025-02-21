//
//  PersonalDataProtectionManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation

protocol PersonalDataProtectionManagerProtocol {
    func checkIsCloudAccountAvailableAndSaveToUserSessionManager() async
    func checkDataBreach(for email: String) async
}

class PersonalDataProtectionManager: PersonalDataProtectionManagerProtocol {
    
    // MARK: - Methods
    
    private func isICloudAccountAvailable() -> Bool {
        return FileManager.default.ubiquityIdentityToken != nil
    }
    
    public func checkIsCloudAccountAvailableAndSaveToUserSessionManager() async {
        UserSessionManager.shared.findMyEnabled = isICloudAccountAvailable()
        if isICloudAccountAvailable() {
            print("✅ iCloud is enabled, 'Find My' might be available.")
        } else {
            print("❌ iCloud is not enabled, 'Find My' may not work.")
        }
    }
    
    public func checkDataBreach(for email: String) async {
        let apiKey = "YOUR_HIBP_API_KEY"  // Replace with your real API key
        let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "https://haveibeenpwned.com/api/v3/breachedaccount/\(encodedEmail)")!
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "hibp-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                UserSessionManager.shared.dataBreachesFound = false
                print("❌ No valid response")
                return
            }

            if httpResponse.statusCode == 200 {
                if let breachInfo = String(data: data, encoding: .utf8) {
                    print("⚠️ Email found in breaches: \(breachInfo)")
                    UserSessionManager.shared.dataBreachesFound = true
                }
            } else if httpResponse.statusCode == 404 {
                UserSessionManager.shared.dataBreachesFound = false
                print("✅ Email is safe. No breaches found.")
            } else {
                UserSessionManager.shared.dataBreachesFound = false
                print("❌ Unexpected response: \(httpResponse.statusCode)")
            }
        } catch {
            UserSessionManager.shared.dataBreachesFound = false
            print("❌ Error: \(error.localizedDescription)")
        }
    }
}

//
//  PersonalDataProtectionManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation

protocol PersonalDataProtectionManagerProtocol {
    func checkIsCloudAccountAvailableAndSaveToUserSessionManager() async
    func checkDataBreach(for email: String) async -> [Breach]
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
    
    public func checkDataBreach(for email: String) async -> [Breach] {
        
        if email.isEmpty {
            UserSessionManager.shared.dataBreachesFound = true
            return []
        }
        
        let baseURL = "https://\(Constants.appDomenName)/api/v3/breachedaccount/"
        let apiKey = Constants.hibpKey
        
        guard let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "\(baseURL)/\(encodedEmail)?truncateResponse=false") else {
            print("❌ Invalid URL")
            return []
        }
        
        var request = URLRequest(url: url)
        
        request.setValue(apiKey, forHTTPHeaderField: "hibp-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                UserSessionManager.shared.dataBreachesFound = false
                print("❌ No valid response")
                return []
            }

            if httpResponse.statusCode == 200 {
                do {
                    let breaches = try JSONDecoder().decode([Breach].self, from: data)
                    if !breaches.isEmpty {
                        print("⚠️ Email found in breaches: \(breaches.map { $0.name })")
                        UserSessionManager.shared.dataBreachesFound = true
                        return breaches
                    }
                } catch {
                    print("❌ JSON Decoding error: \(error.localizedDescription)")
                }
            } else if httpResponse.statusCode == 404 {
                UserSessionManager.shared.dataBreachesFound = false
                print("✅ Email is safe. No breaches found.")
                return []
            } else {
                UserSessionManager.shared.dataBreachesFound = false
                print("❌ Unexpected response: \(httpResponse.statusCode)")
                return []
            }
        } catch {
            UserSessionManager.shared.dataBreachesFound = false
            print("❌ Error: \(error.localizedDescription)")
            return []
        }
        return []
    }
}


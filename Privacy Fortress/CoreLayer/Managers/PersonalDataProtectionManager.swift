//
//  PersonalDataProtectionManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 21/02/25.
//

import Foundation

protocol PersonalDataProtectionManagerProtocol {
    func checkIsCloudAccountAvailableAndSaveToUserSessionManager() async
    func checkDataBreach(for email: String, isItFirstLaunch: Bool) async -> [Breach]
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
    
    public func checkDataBreach(for email: String, isItFirstLaunch: Bool = true) async -> [Breach] {
        
        if isItFirstLaunch {
            UserSessionManager.shared.dataBreachesFound = true
            return []
        }
        
        guard let apiKey = KeychainWrapperManager.shared.getAPIHIBPKey(),
              let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "https://\(Constants.appDomenName)/breachedaccount/\(encodedEmail)?truncateResponse=false") else {
            print("❌ Invalid API Key or URL")
            return []
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "hibp-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(Constants.apiClientApp, forHTTPHeaderField: "API-CLIENT-APP")
        request.setValue(Constants.apiClientApp, forHTTPHeaderField: "User-Agent")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            
            switch httpResponse.statusCode {
            case 200:
                guard !data.isEmpty else {
                    print("❌ Empty response data")
                    return []
                }
                let breaches = try JSONDecoder().decode([Breach].self, from: data)
                UserSessionManager.shared.dataBreachesFound = !breaches.isEmpty
                return breaches
                
            case 404:
                print("✅ No breaches found for this email.")
                return []
                
            default:
                print("❌ Unexpected HTTP status: \(httpResponse.statusCode)")
                return []
            }
            
        } catch {
            print("❌ Network/Error: \(error.localizedDescription)")
            return []
        }
    }
}


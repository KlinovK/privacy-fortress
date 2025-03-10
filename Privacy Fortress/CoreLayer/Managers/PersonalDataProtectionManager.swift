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

final class PersonalDataProtectionManager: PersonalDataProtectionManagerProtocol {
    
    // MARK: - Private Methods
    
    private func isICloudAccountAvailable() -> Bool {
        FileManager.default.ubiquityIdentityToken != nil
    }
    
    private func fetchBreaches(from url: URL, with apiKey: String) async throws -> [Breach] {
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "hibp-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(Constants.clientApp, forHTTPHeaderField: "API-CLIENT-APP")
        request.setValue(Constants.clientApp, forHTTPHeaderField: "User-Agent")
        
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
            return try JSONDecoder().decode([Breach].self, from: data)
            
        case 404:
            print("✅ No breaches found for this email.")
            return []
            
        default:
            print("❌ Unexpected HTTP status: \(httpResponse.statusCode)")
            return []
        }
    }
    
    // MARK: - Public Methods
    
    public func checkIsCloudAccountAvailableAndSaveToUserSessionManager() async {
        let isAvailable = isICloudAccountAvailable()
        UserSessionManager.shared.isFindMyEnabled = isAvailable
        print(isAvailable ? "✅ iCloud is enabled, 'Find My' might be available." : "❌ iCloud is not enabled, 'Find My' may not work.")
    }
    
    public func checkDataBreach(for email: String, isItFirstLaunch: Bool = true) async -> [Breach] {
        if isItFirstLaunch {
            UserSessionManager.shared.hasDataBreaches = true
            return []
        }
        
        guard let apiKey = KeychainWrapperManager.shared.getHIBPAPIKey(),
              let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "https://\(Constants.pwndAppDomainName)/breachedaccount/\(encodedEmail)?truncateResponse=false") else {
            print("❌ Invalid API Key or URL")
            return []
        }
        
        do {
            let breaches = try await fetchBreaches(from: url, with: apiKey)
            UserSessionManager.shared.hasDataBreaches = !breaches.isEmpty
            return breaches
        } catch {
            print("❌ Network/Error: \(error.localizedDescription)")
            return []
        }
    }
}

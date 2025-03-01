//
//  HTTPGenerecClient.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation

class HTTPGenerecClient {
    
    static let shared = HTTPGenerecClient()
    
    private init() {}
    
    func request<T: Decodable>(
        url: String,
        method: HTTPMethod = .GET,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        guard let url = URL(string: url) else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters = parameters, (method == .POST || method == .PUT) {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch {
                throw HTTPError.requestFailed
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw HTTPError.responseError
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw HTTPError.decodingError
        }
    }
}

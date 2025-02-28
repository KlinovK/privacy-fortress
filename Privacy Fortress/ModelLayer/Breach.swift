//
//  Breach.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 27/02/25.
//

import Foundation

struct Breach: Codable {
    let name: String
    let title: String
    let domain: String
    let breachDate: String
    let addedDate: String
    let modifiedDate: String
    let pwnCount: Int
    let description: String
    let logoPath: String?
    let dataClasses: [String]
    let isVerified: Bool
    let isFabricated: Bool
    let isSensitive: Bool
    let isRetired: Bool
    let isSpamList: Bool
    let isMalware: Bool
    let isSubscriptionFree: Bool
    let isStealerLog: Bool
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case title = "Title"
        case domain = "Domain"
        case breachDate = "BreachDate"
        case addedDate = "AddedDate"
        case modifiedDate = "ModifiedDate"
        case pwnCount = "PwnCount"
        case description = "Description"
        case logoPath = "LogoPath"
        case dataClasses = "DataClasses"
        case isVerified = "IsVerified"
        case isFabricated = "IsFabricated"
        case isSensitive = "IsSensitive"
        case isRetired = "IsRetired"
        case isSpamList = "IsSpamList"
        case isMalware = "IsMalware"
        case isSubscriptionFree = "IsSubscriptionFree"
        case isStealerLog = "IsStealerLog"
    }
    
    public func getFormattedDescription() -> String {
        let cleanedText = self.description.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression,
            range: nil
        )
        let sentences = split(cleanedText)
        return sentences.joined(separator: "\n\n")
    }
    
    private func split(_ text: String) -> [String] {
        var sentences = [String]()
        var currentSentence = ""
        
        let textArray = Array(text)
        for i in 0 ..< textArray.count {
            currentSentence.append(textArray[i])
            
            if textArray[i] == "." {
                if i + 1 < textArray.count, textArray[i + 1] == " ", i + 2 < textArray.count, textArray[i + 2].isUppercase {
                    sentences.append(currentSentence.trimmingCharacters(in: .whitespacesAndNewlines))
                    currentSentence = ""
                }
            }
        }
        
        if !currentSentence.isEmpty {
            sentences.append(currentSentence.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        return sentences
    }
}

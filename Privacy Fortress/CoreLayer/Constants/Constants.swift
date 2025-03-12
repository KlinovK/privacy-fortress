//
//  Constants.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation
import UIKit

public struct Constants {
    
    public static let kHBIPKey = "88fa34a9-1453-43ed-a773-80d7b792e670"
    public static let lowestIOSVersion = 16
    public static let pwndAppDomainName = "pwnd.privacyfortressapp.com"
    public static let clientApp = "com.Bridigi.Privacy-Fortress"
    public static let apiBaseURL = "https://api.privacyfortressapp.com"
    public static let isIPad = UIDevice.current.userInterfaceIdiom == .pad
    public static let contentBlockerIdentifier = "com.Bridigi.Privacy-Fortress.PrivacyFortressContentBlocker"
    
    public static let deepLinkURLPath = ""
    public static let appsFlyerDevKey = ""
    public static let appleFlyerAppID = ""
    public static let appStoreID = "6742862634"
    public static let productIdentifier = "com.Bridigi.Privacy_Fortress.premium"
    public static let apphudAPIKey = "boFRAYgH9xVZi2ASdyNfG8"
    public static let termsAndConditionsURLString = "https://privacyfortress.com/terms-and-conditions/"
    public static let privacyPolicyURLString = "https://privacyfortress.com/privacy-policy/"
    
}

// MARK: - UserSessionKey

enum UserSessionKey: String {
    case hasLaunchedBefore = "kHasLaunchedBefore"
    case uniqueUserID = "kUniqueUserID"
    case fcmToken = "kFCMTokenKeychainKey"
    case isUserSubscribed = "kIsUserSubscribed"
    case lastScanTimestamp = "kLastScanTimestamp"
    case findMyEnabled = "kFindMyEnabled"
    case dataBreachesFound = "kDataBreachesFound"
    case isAnyPasswordsSavedToSafeStorage = "kIsAnyPasswordsSavedToSafeStorage"
    case isMediaSafe = "kIsMediaSafe"
    case isDeviceLockEnabled = "kIsDeviceLockEnabled"
    case isDeviceVersionLowerThanRequired = "isDeviceVersionLowerThanRequired"
    case isMaliciousSitesProtectionEnabled = "kIsMaliciousSitesProtectionEnabled"
    case isSecureNetwork = "kIsSecureNetwork"
    case hibpApiKey = "kHibpApiKey"
    case passcodeKeychainKey = "kPasscodeKeychainKey"
    case kOriginalTransactionId = "kOriginalTransactionId"
    case appsFlyerAttributionData = "AppsFlyerAttributionData"
}

//
//  Constants.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation
import UIKit

public struct Constants {
    
    public static let isIPad = UIDevice.current.userInterfaceIdiom == .pad
    public static let contentBlockerIdentifier = "com.Bridigi.Privacy-Fortress.PrivacyFortressContentBlocker"
    public static let termsAndConditionsURLString = "https://privacyfortress.com/terms-and-conditions/"
    public static let privacyPolicyURLString = "https://privacyfortress.com/privacy-policy/"
    
    // MARK: - Change after release
    
    public static let appStoreID = "YOUR_APP_ID"
    public static let lowestIOSVersion = 16
    public static let appDomenName = "pwnd.privacyfortressapp.com"
    public static let apiClientApp = "com.Bridigi.Privacy-Fortress"

    // MARK: - User Defaults

    enum UserDefaultsKeys {
        static let kFindMyEnabled = "kFindMyEnabled"
        static let kDataBreachesFound = "kDataBreachesFound"
        static let kIsAnyPasswordsSavedToSafeStorage = "kIsAnyPasswordsSavedToSafeStorage"
        static let kIsMediaSafe = "kIsMediaSafe"
        static let kIsDeviceLockEnabled = "kIsDeviceLockEnabled"
        static let isDeviceVersionLowerThanRequired = "isDeviceVersionLowerThanRequired"
        static let kIsMaliciousSitesProtectionEnabled = "kIsMaliciousSitesProtectionEnabled"
        static let kIsSecureNetwork = "kIsSecureNetwork"
        static let kLastScanTimestamp = "kLastScanTimestamp"
        static let kIsUserSubscribed = "kFindMyEnabled"
    }

}

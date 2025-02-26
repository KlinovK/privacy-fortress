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
    public static let appID = "itms-apps://itunes.apple.com/app/idYOUR_APP_ID?action=write-review"
    public static let thirtyDays: TimeInterval = 30 * 24 * 60 * 60
    
    // MARK: - Change in future
    public static let lowestIOSVersion = 16

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
    }

}

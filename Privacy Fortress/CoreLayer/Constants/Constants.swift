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

    // MARK: - User Defaults

    enum UserDefaultsKeys {
        static let kFindMyEnabled = "kFindMyEnabled"
        static let kDataBreachesFound = "kDataBreachesFound"
        static let kIsAnyPasswordsSavedToSafeStorage = "kIsAnyPasswordsSavedToSafeStorage"
        static let kIsMediaSafe = "kIsMediaSafe"
        static let kIsDeviceLockEnabled = "kIsDeviceLockEnabled"
        static let kIsDeviceVersionLowerThan13 = "kIsDeviceVersionLowerThan13"
        static let kIsMaliciousSitesProtectionEnabled = "kIsMaliciousSitesProtectionEnabled"
        static let kIsSecureNetwork = "kIsSecureNetwork"
    }

}

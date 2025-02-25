//
//  IconsManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

public enum IconsManager: String {
    
    case appLogo = "ic_app_logo"
    case icWifiSecurity = "ic_wifi_security"
    case icSystemSecurity = "ic_system_security"
    case icPersonalDataSecurity = "ic_personal_data_security"
    case icPersonalStorage = "ic_personal_storage"
    case icAppLogoStartScreen = "ic_app_logo_start_screen"
    case icAnalyzing = "ic_analyzing"
    case icCheckmark = "ic_checkmark"
    case icIssuesFound = "ic_issues_found"
    case icSssuesNotFound = "ic_issues_not_found"
    case icSitesBlocked = "ic_sites_blocked"
    case icWifiIsSecure = "ic_wifi_is_secure"
    case icDataBreaches = "ic_data_breaches"
    case icFindMy = "ic_find_my"
    case icDeviceLock = "ic_device_lock"
    case icIosUpToDate = "ic_ios_up_to_date"
    case icFilesSecure = "ic_files_secure"
    case icPasswordSecure = "ic_password_secure"
    case icAppLogoWarning = "ic_app_logo_warning"
    case icDiamond = "ic_diamond"
    case icSettings = "ic_settings"
    case icUnlockPremium = "ic_unlock_premium"
    case icChevronRight = "ic_chevron_right"
    case icRateUs = "ic_rate_us"
    case icShareApp = "ic_share_app"
    case icPrivacyPolicy = "ic_privacy_policy"
    case icTermsOfService = "ic_terms_of_service"
    case icChangePassword = "ic_change_password"
    case icSubscription = "ic_subscription"
    case icFirst = "ic_first"
    case icSettingsSmall = "ic_settings_small"
    case icSecond = "ic_second"
    case icApplications = "ic_applications"
    case icThird = "ic_third"
    case icSafari = "ic_safari"
    case icFourth = "ic_fourth"
    case icFifth = "ic_fifth"
    case icAppiconSmall = "ic_appicon_small"
    case icSwitcher = "ic_switcher"
    case icModem = "ic_modem"
    case icSettingsCell = "ic_settings_cell"
    case icGeneralSettings = "ic_general_settings"
    case icAvailableUpdate = "ic_available_update"
    case icDeviceLockEnabled = "ic_device_lock_enabled"
    case icDeviceLockDisabled = "ic_device_lock_disabled"
    case icFaceIDPasscode = "ic_faceID_passcode"
    
    var image: String {
        self.rawValue
    }
    
}

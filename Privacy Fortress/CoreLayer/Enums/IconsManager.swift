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
    
    var image: String {
        self.rawValue
    }
}

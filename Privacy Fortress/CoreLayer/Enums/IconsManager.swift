//
//  IconsManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

public enum IconsManager: String {
    case appLogo = "ic_app_logo"
    case icWifiSecuritySplash = "ic_wifi_security_splash_screen_logo"
    case icSystemSecuritySplash = "ic_system_security_splash_screen"
    case icPersonalSataSecuritySplash = "ic_personal_data_security_splash"
    case icPersonalStorageSplash = "ic_personal_storage_splash"
    
    var image: String {
        self.rawValue
    }
}

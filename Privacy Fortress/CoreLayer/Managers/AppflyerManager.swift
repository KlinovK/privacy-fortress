//
//  AppflyerManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 07/03/25.
//

import Foundation
import AppsFlyerLib
import FirebaseAnalytics

class AppFlyerManager {
    
    static let shared = AppFlyerManager()
    
    private init() {}
    
    public func configure() {
        AppsFlyerLib.shared().appsFlyerDevKey = Constants.appsFlyerDevKey
        AppsFlyerLib.shared().appleAppID = Constants.appleFlyerAppID
        #if DEBUG
        AppsFlyerLib.shared().isDebug = true
        #endif
    }
    
    public func start() {
        AppsFlyerLib.shared().start()
    }
    
     public func logEvent(name: String, productId: String) {
         let parameters: [String: Any] = [
             AFEventParamContentId: productId
         ]
         Analytics.logEvent(name, parameters: parameters)
         AppsFlyerLib.shared().logEvent(name, withValues: parameters)
         print("AppsFlyer Event Logged: \(name) with params: \(parameters)")
     }
}

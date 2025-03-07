//
//  AppflyerManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 07/03/25.
//

import Foundation
import AppsFlyerLib

class AppFlyerManager {
    
    static let shared = AppFlyerManager()
    
    private init() {}
    
    func configure() {
        AppsFlyerLib.shared().appsFlyerDevKey = Constants.appsFlyerDevKey
        AppsFlyerLib.shared().appleAppID = Constants.appleFlyerAppID
        #if DEBUG
        AppsFlyerLib.shared().isDebug = true
        #endif
    }
    
    func start() {
        AppsFlyerLib.shared().start()
    }
    
    func sendPurchaseEvent(productId: String) {
        let parameters: [String: Any] = [
            AFEventParamContentId: productId
        ]
        
        AppsFlyerLib.shared().logEvent(AFEventPurchase, withValues: parameters)
    }
}

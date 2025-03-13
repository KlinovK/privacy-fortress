//
//  AppDelegate.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 01/03/25.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import AppsFlyerLib
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate, AppsFlyerLibDelegate {
    
    private lazy var remoteService = RemoteService()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFCMAndRemoteNotifications()
        UserSessionManager.shared.handleFirstLaunch()
        KeychainWrapperManager.shared.saveHIBPAPIKey()
        setupNavigationBarAppearance()
        setupAppsFlyer()
        setupApphud()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppFlyerManager.shared.start()
    }
}

// MARK: - MessagingDelegate

extension AppDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("❌ Failed to register for APNS: \(error.localizedDescription)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let token = fcmToken {
            UserSessionManager.shared.fcmToken = token
            Task {
                await remoteService.sendFCMToken(token)
                await remoteService.sendUserData()
            }
        }
    }
}

// MARK: - Third-Party SDK Setup

extension AppDelegate {
    
    private func setupApphud() {
        Task {
            await ApphudManager.shared.setupApphud()
        }
    }
    
    private func setupFCMAndRemoteNotifications() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

    }

}

// MARK: - AppsFlyer Delegate

extension AppDelegate {
    
    private func setupAppsFlyer() {
        AppFlyerManager.shared.configure()
    }
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        print("📊 AppsFlyer Attribution Data: \(conversionInfo)")
        UserSessionManager.shared.saveAppsFlyerAttribution(conversionInfo)
    }
    
    func onConversionDataFail(_ error: Error) {
        print("❌ Failed to retrieve AppsFlyer attribution data: \(error)")
    }
    
}

// MARK: - User Notification Center Delegate

extension AppDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        completionHandler()
    }
}

// MARK: - Appearance

extension AppDelegate {
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}

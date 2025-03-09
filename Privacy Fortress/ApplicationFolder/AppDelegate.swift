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
        KeychainWrapperManager.shared.saveHIBPAPIKey()
        setupNavigationBarAppearance()
        setupApphud()
        AppFlyerManager.shared.configure()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppFlyerManager.shared.start()
    }
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        print("Attribution Data: \(conversionInfo)")
        UserSessionManager.shared.saveAppsFlyerAttribution(conversionInfo)
    }
    
    func onConversionDataFail(_ error: Error) {
        print("Failed to retrieve attribution data: \(error)")
    }
}

// MARK: - Notification Center

extension AppDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      completionHandler([[.banner, .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        NotificationCenter.default.post(name: Notification.Name("NotificationTapped"), object: userInfo)
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("❌ Failed to register for APNS: \(error.localizedDescription)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let token = fcmToken {
            UserSessionManager.shared.fcmToken = token
        }
    }
    
    private func setupApphud() {
        Task {
            await ApphudManager.shared.setupApphud()
        }
    }
    
    private func setupFCMAndRemoteNotifications() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print("Permission granted: \(granted)")
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }

            Task {
                #warning("Uncomment before release")
    //            await remoteService.sendFCMToken(UserSessionManager.shared.fcmToken ?? "")
    //            await remoteService.sendUserData()
            }
        }
    }
    
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

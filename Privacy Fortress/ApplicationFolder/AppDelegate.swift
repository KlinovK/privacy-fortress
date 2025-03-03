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

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    private lazy var remoteService = RemoteService()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFCMAndRemoteNotifications()
        application.registerForRemoteNotifications()
        _ = UserSessionManager.shared.getOrCreateRandomUserID()
        return true
    }
    
}

// MARK: - Notification Center

extension AppDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("📲 APNS Token received")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("❌ Failed to register for APNS: \(error.localizedDescription)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let token = fcmToken {
            UserSessionManager.shared.fcmToken = token
        }
        
        Task {
            #warning("Uncomment before release")
//            await remoteService.sendFCMToken(UserSessionManager.shared.fcmToken ?? "")
//            await remoteService.sendUserData()
        }
                
    }
    
    private func setupFCMAndRemoteNotifications() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print("Permission granted: \(granted)")
        }
    }
}


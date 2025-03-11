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
        
        checkNotificationAuthorization()
    }
    
    private func checkNotificationAuthorization() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self?.requestNotificationPermission()
            case .denied:
                DispatchQueue.main.async {
                    self?.showSettingsAlert()
                }
            case .authorized, .provisional, .ephemeral:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            @unknown default:
                break
            }
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print("Permission granted: \(granted)")
            
            DispatchQueue.main.async {
                if granted {
                    Task {
#warning("Uncomment before release")
                        //                                                await remoteService.sendFCMToken(UserSessionManager.shared.fcmToken ?? "")
                        //                                                await remoteService.sendUserData()
                    }
                    UIApplication.shared.registerForRemoteNotifications()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.checkNotificationAuthorization()
                    }
                }
            }
        }
    }
    
    private func showSettingsAlert() {
        let alert = UIAlertController(
            title: "Enable Notifications",
            message: "To stay updated, please enable notifications in Settings.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first(where: { $0.isKeyWindow }),
               let rootViewController = window.rootViewController {
                rootViewController.present(alert, animated: true)
            }
        }
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
        NotificationCenter.default.post(name: Notification.Name("NotificationTapped"), object: userInfo)
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

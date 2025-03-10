//
//  Privacy_FortressApp.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

@main
struct PrivacyFortressApp: App {
    
    private let persistenceController = LocalStorageService.shared
    
    @StateObject private var notificationManager = NotificationManager.shared
    @State private var navigateToPaywall = false
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SplashScreenView()
                    .navigationDestination(isPresented: $navigateToPaywall) {
                        PaywallScreen()
                    }
            }
            .onOpenURL(perform: handleDeepLink)
            .onChange(of: notificationManager.actionType) { action in
                if let action = action, action == "special" {
                    navigateToPaywall = true
                }
            }
        }
    }
    
    private func handleDeepLink(_ url: URL) {
        if url.scheme == "PrivacyFortress", url.host == "paywall" || url.path.contains(Constants.deepLinkURLPath) {
            navigateToPaywall = true
        }
    }
}


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
            .environment(\.managedObjectContext, persistenceController.context)
            .onOpenURL(perform: handleDeepLink)
        }
    }
    
    private func handleDeepLink(_ url: URL) {
        if url.scheme == "PrivacyFortress", url.host == "paywall" || url.path.contains(Constants.deepLinkURLPath) {
            navigateToPaywall = true
        }
    }
}


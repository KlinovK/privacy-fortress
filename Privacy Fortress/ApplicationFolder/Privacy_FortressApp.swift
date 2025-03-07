//
//  Privacy_FortressApp.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI
import CoreData

@main
struct PrivacyFortressApp: App {
    
    let persistenceController = LocalStorageService.shared
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
            
            .onOpenURL { url in
                if url.scheme == "PrivacyFortress" && url.host == "paywall" || url.path.contains(Constants.deepLinkURLPath) {
                    navigateToPaywall = true
                }
            }
            
            #warning("Urgent. Will not work uri or universal links. Follow instructions")
            /*
            Link for test "PrivacyFortress://paywall" URI case
             Need your link with same format
             Need to update Info.plist
             <key>CFBundleURLTypes</key>
             <array>
                 <dict>
                     <key>CFBundleURLSchemes</key>
                     <array>
                         <string>PrivacyFortress</string>
                     </array>
                     <key>CFBundleURLName</key>
                     <string>com.yourcompany.PrivacyFortress</string>
                 </dict>
             </array>
             
             Universal link case
             Project
             Target -> Privacy Fortress
             Signing
             Capabilities
             Associated Domains
             Update associated domain, right now is applinks:privacyfortressapp.com
             */
        
        }
    }
}

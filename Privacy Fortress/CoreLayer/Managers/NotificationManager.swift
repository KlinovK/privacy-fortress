//
//  NotificationManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 09/03/25.
//

import Foundation

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    @Published var actionType: String? = nil
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotificationTap),
            name: Notification.Name("NotificationTapped"),
            object: nil
        )
    }

    @objc private func handleNotificationTap(notification: Notification) {
        if let userInfo = notification.object as? [String: Any],
           let action = userInfo["action"] as? String {
            DispatchQueue.main.async {
                self.actionType = action
            }
        }
    }
}

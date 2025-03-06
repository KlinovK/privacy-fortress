//
//  KeyboardObserver.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 06/03/25.
//

import Foundation
import SwiftUI

class KeyboardObserver: ObservableObject {
    @Published var height: CGFloat = 0
    
    init() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.height = keyboardFrame.height
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            self.height = 0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

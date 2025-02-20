//
//  ColorManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

enum ColorManager: String {
    
    case mainBackground = "MainBackgroundColor"
    case splashScreenBackground1 = "SplashScreenBackground1"
    case splashScreenBackground2 = "SplashScreenBackground2"
    case textDefaultColor = "TextDefaultColor"
    case buttonActiveColor = "ButtonActiveColor"
    case analyzingCircleBorderColor = "AnalyzingCircleBorderColor"

    var color: Color {
        Color(self.rawValue)
    }
}


//
//  FontsManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation

enum FontsManager: String {
    
    case SFbold = "SFProDisplay-Bold"
    case SFSemibold = "SFProDisplay-Semibold"
    case SFlight = "SFProDisplay-Light"
    case SFRegular = "SFProDisplay-Regular"

    var font: String {
        self.rawValue
    }
    
}

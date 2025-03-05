//
//  MediaItem.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import Foundation
import UIKit

struct MediaItem: Hashable, Identifiable {
    let id = UUID()
    let image: UIImage
    let dateAdded: Date
    
    static func image(_ uiImage: UIImage) -> MediaItem {
        MediaItem(image: uiImage, dateAdded: Date())
    }
}

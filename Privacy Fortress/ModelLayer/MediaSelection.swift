//
//  MediaSelection.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import Foundation
import Photos
import UIKit

struct MediaSelection: Equatable {
    let image: UIImage
    let asset: PHAsset
    static func == (lhs: MediaSelection, rhs: MediaSelection) -> Bool {
        lhs.asset.localIdentifier == rhs.asset.localIdentifier
    }
}

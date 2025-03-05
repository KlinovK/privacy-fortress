//
//  UIImage.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import UIKit

extension UIImage {
    func compressed(maxSizeMB: Double = 1.0) -> UIImage? {
        guard let data = jpegData(compressionQuality: 1.0) else { return nil }
        let maxBytes = maxSizeMB * 1024 * 1024
        if Double(data.count) <= maxBytes { return self }
        
        var compression: CGFloat = 0.9
        while compression > 0.1 {
            if let compressedData = jpegData(compressionQuality: compression),
               Double(compressedData.count) <= maxBytes {
                return UIImage(data: compressedData)
            }
            compression -= 0.1
        }
        return nil
    }
}

//
//  PurchaseError.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 06/03/25.
//

import Foundation

enum PurchaseError: Error, LocalizedError {
    case productNotFound
    case unknown
    var errorDescription: String? {
        switch self {
        case .productNotFound:
            return "Product not found."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

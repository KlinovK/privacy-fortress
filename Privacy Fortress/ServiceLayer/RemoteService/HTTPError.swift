//
//  HTTPError.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 01/03/25.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case requestFailed
    case responseError
    case decodingError
}

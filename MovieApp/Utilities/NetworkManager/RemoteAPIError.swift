//
//  RemoteAPIError.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import Foundation

enum RemoteAPIError: Error {
    case unknown
    case httpError
    case tokenExpired
    case noData
}

//
//  RemoteAPIError.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import Foundation

enum RemoteAPIError: String, Error {
    case invalidURL = "Invalid URL"
    case invalidResponse = "Invalid Response from server"
    case invalidData = "Data are not valid"
    case unableToComplete = "Unable to complete request"
    case failedToParse = "Failed to parse data"
    case noInternet = "Internet connection not available"
}

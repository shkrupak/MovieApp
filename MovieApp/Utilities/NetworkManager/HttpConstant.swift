//
//  HttpConstant.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPHeaderType: String {
    case contentType = "Content-Type"
    case accept = "Accept"
}

enum HTTPHeaderValue: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
    case formData = "application/x-www-form-urlencoded charset=utf-8"
}

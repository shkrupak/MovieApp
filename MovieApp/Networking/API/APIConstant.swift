//
//  APIConstant.swift
//  
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

struct APIConstant {
    struct MovieBaseURL {
        static let prod = ""
        static let dev = ""
    }
    
    //current base url
    static private let baseURL = MovieBaseURL.prod
    
    struct Endpoints {
        static var movieSearch: String {APIConstant.baseURL + "/search"}
        static var movieDetail: String {APIConstant.baseURL + "/detail"}
    }
}

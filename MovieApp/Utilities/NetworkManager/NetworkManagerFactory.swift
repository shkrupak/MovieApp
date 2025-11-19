//
//  NetworkManagerFactory.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import Foundation


typealias Parameters = [String: Any]
typealias Headers = [String: String]

class NetworkRequestFactory {
    
    static func createURLRequest(requestURL: URL,
                                 queryItems: [URLQueryItem] = [],
                                 method: HTTPMethod,
                                 headers: Headers = [:],
                                 parameters: Parameters = [:]) -> URLRequest? {
        
        let urlString = requestURL.absoluteString
        var urlComponents = URLComponents(string: urlString)
        
        if !queryItems.isEmpty {
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        
        if !headers.isEmpty {
            headers.forEach({ (key, value) in
                request.addValue(key, forHTTPHeaderField: value)
            })
        }
        
        if !parameters.isEmpty {
            let paramRequest = EncoderHelper.shared.encodeFormData(from: parameters, request: request)
            return paramRequest
        }
        
        return request
    }
}

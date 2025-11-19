//
//  EncoderHelper.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import Foundation

class EncoderHelper {
    static let shared = EncoderHelper()
    
    private init() { }
    
    func getPostString(params: [String:Any]) -> String {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { $0 }.joined(separator: "&")
    }
    
    func encodeFormData(from params: [String: Any], request: URLRequest) -> URLRequest {
        var request = request
        let formData = getPostString(params: params)
        request.httpBody = formData.data(using: .utf8)
        return request
    }
}

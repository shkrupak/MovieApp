//
//  MoviesNetworkManager.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import Foundation

class MoviesNetworkManager: NetworkManager {
    func loadData(request: URLRequest, completion: @escaping (Result<Data, RemoteAPIError>) -> Void) {
        if Network.isNetworkAvailable() {
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(RemoteAPIError.unableToComplete))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(RemoteAPIError.unableToComplete))
                    return
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    print(httpResponse.statusCode)
                    completion(.failure(RemoteAPIError.invalidResponse))
                    return
                }
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(RemoteAPIError.invalidData))
                }
            }.resume()
        }
        else {
            completion(.failure(.noInternet))
        }
    }
}

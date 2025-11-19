//
//  MoviesNetworkManager.swift
//  MovieApp
//
//  Created by Rupak Shakya on 19/11/2025.
//

import Foundation

class MoviesNetworkManager: NetworkManager {
    func loadData(request: URLRequest, completion: @escaping (Result<Data, any Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(RemoteAPIError.unknown))
                return
            }
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(RemoteAPIError.httpError))
                return
            }
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(RemoteAPIError.noData))
            }
        }.resume()
    }
}

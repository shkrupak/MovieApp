//
//  SearchMovieService.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

final class SearchMovieService: SearchMovieServiceProtocol {
    let networkManager = MoviesNetworkManager()
    
    func requestSearchMovie(query: String, page: Int = 1, completion: @escaping (Result<MovieResponseModel, RemoteAPIError>) -> Void) {
        if Network.isNetworkAvailable() {
            guard let urlRequest = makeURLRequest(query: query, page: page) else {
                completion(.failure(.invalidURL))
                return
            }
            networkManager.loadData(request: urlRequest) { response in
                switch response {
                case .success(let data):
                    do {
                        let searchMovieResposne = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                        completion(.success(searchMovieResposne))
                    }
                    catch let error {
                        print(error.localizedDescription)
                        completion(.failure(.failedToParse))
                    }
                    
                case .failure(_):
                    completion(.failure(RemoteAPIError.unableToComplete))
                }
            }
        } else {
            completion(.failure(RemoteAPIError.noInternet))
        }
        
        
    }
}

extension SearchMovieService {
    private func makeURLRequest(query: String, page: Int = 1) -> URLRequest? {
        guard let url = URL(string: APIConstant.Endpoints.movieSearch) else {return nil}
            
        var qureyItems = [URLQueryItem]()
        qureyItems.append(URLQueryItem(name: "query", value: query))
        qureyItems.append(URLQueryItem(name: "page", value: "\(page)"))
        qureyItems.append(URLQueryItem(name: "api_key", value: "5daa06cb582358b3ccdc3b5810ebf15a"))
        
        let urlRequest = NetworkURLRequestFactory.createURLRequest(requestURL: url, queryItems: qureyItems, method: .get)
        
        return urlRequest
    }
}

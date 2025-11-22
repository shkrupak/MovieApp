//
//  HomeService.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

final class HomeService: HomeServiceProtocol {
    let networkManager = MoviesNetworkManager()
    
    func requestPopularMovie(completion: @escaping (Result<MovieResponseModel, RemoteAPIError>) -> Void) {
        if Network.isNetworkAvailable() {
            guard let urlRequest = makeURLRequest() else {
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
        }
        else {
            completion(.failure(RemoteAPIError.noInternet))
        }   
    }
}

extension HomeService {
    private func makeURLRequest() -> URLRequest? {
        guard let url = URL(string: APIConstant.Endpoints.popularMovie) else {return nil}
            
        var qureyItems = [URLQueryItem]()
        qureyItems.append(URLQueryItem(name: "api_key", value: "5daa06cb582358b3ccdc3b5810ebf15a"))
        
        let urlRequest = NetworkURLRequestFactory.createURLRequest(requestURL: url, queryItems: qureyItems, method: .get)
        
        return urlRequest
    }
}

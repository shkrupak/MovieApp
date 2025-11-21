//
//  MovieDetailService.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

final class MovieDetailService: MovieDetailServiceProtocol {
    let networkManager = MoviesNetworkManager()
    
    func requestMovieDetail(movieID: Int, completion: @escaping (Result<MovieDetailResponseModel, RemoteAPIError>) -> Void) {
        
        guard let urlRequest = makeURLRequest(movieID: movieID) else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkManager.loadData(request: urlRequest) { response in
            switch response {
            case .success(let data):
                do {
                    let movieDetailResponse = try JSONDecoder().decode(MovieDetailResponseModel.self, from: data)
                    completion(.success(movieDetailResponse))
                }
                catch {
                    completion(.failure(.failedToParse))
                }
            case .failure(_):
                completion(.failure(.unableToComplete))
            }
        }
    }
}

extension MovieDetailService {
    private func makeURLRequest(movieID: Int) -> URLRequest? {
        guard let url = URL(string: "\(APIConstant.Endpoints.movieDetail)\(movieID)") else { return nil }
        
        var qureyItems = [URLQueryItem]()
        qureyItems.append(URLQueryItem(name: "api_key", value: "5daa06cb582358b3ccdc3b5810ebf15a"))
        
        let urlRequest = NetworkURLRequestFactory.createURLRequest(requestURL: url, queryItems: qureyItems, method: .get)
        
        return urlRequest
    }
}

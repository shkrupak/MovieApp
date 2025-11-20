//
//  SearchMovieService.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

final class SearchMovieService: SearchMovieServiceProtocol {
    let networkManager = MoviesNetworkManager()
    
    func requestSearchMovie(query: String, completion: @escaping (Result<MovieResponseModel, RemoteAPIError>) -> Void) {
        guard let urlRequest = makeURLRequest(query: query) else {
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
}

extension SearchMovieService {
    private func makeURLRequest(query: String) -> URLRequest? {
        guard let url = URL(string: APIConstant.Endpoints.movieSearch) else {return nil}
        let headers = APIConstant.getHeader()
        
        var qureyItems = [URLQueryItem]()
        qureyItems.append(URLQueryItem(name: "query", value: query))
        qureyItems.append(URLQueryItem(name: "api_key", value: "5daa06cb582358b3ccdc3b5810ebf15a"))
        
        let urlRequest = NetworkURLRequestFactory.createURLRequest(requestURL: url, queryItems: qureyItems, method: .get)
        print(urlRequest)
        return urlRequest
    }
}

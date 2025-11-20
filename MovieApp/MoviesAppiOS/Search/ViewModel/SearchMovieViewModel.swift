//
//  SearchMovieViewModel.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

class SearchMovieViewModel {
    var moviesResponse: MovieResponseModel?
    private let searchMovieService = SearchMovieService()
    var isLoading: Bool = false
    
    private func isValidQuery(query: String) -> Bool {
        return query != ""
    }
    
    func requestSearchMovie(query: String, completion: @escaping (Bool, String) -> Void) {
        if isValidQuery(query: query) {
            isLoading = true
            searchMovieService.requestSearchMovie(query: query) { [weak self] response in
                guard let self = self else {
                    completion(false, "Unable to complete the search request")
                    return
                }
                
                self.isLoading = false
                
                switch response {
                case .success(let result):
                    self.moviesResponse = result
                    completion(true, "Search completed")
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
}

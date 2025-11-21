//
//  SearchMovieViewModel.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

class SearchMovieViewModel {
    private(set) var moviesResponse: MovieResponseModel?
    private let searchMovieService = SearchMovieService()
    private(set) var isLoading: Bool = false {
        didSet { onLoadingChange?(isLoading)}
    }
    
    var onLoadingChange: ((Bool) -> Void)?
    var onStateChange: ((SearchState) -> Void)?
    
    enum SearchState {
        case success
        case failure(String)
        case cleared
    }
    
    func requestSearchMovie(query: String) {
        if isValidQuery(query: query) {
            isLoading = true
            searchMovieService.requestSearchMovie(query: query) { [weak self] response in
                guard let self = self else {
                    return
                }
                self.isLoading = false
                
                
                switch response {
                case .success(let result):
                    self.moviesResponse = result
                    self.onStateChange?(((self.moviesResponse?.results.isEmpty) ?? true) ? .failure("No movies found") : .success)
                case .failure(let error):
                    self.onStateChange?(.failure(error.localizedDescription))
                }
            }
        }
        else {
            moviesResponse = nil
            self.onStateChange?(.cleared)
        }
    }
    
    private func isValidQuery(query: String) -> Bool {
        return !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

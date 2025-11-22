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
    
    private let repository: SearchMovieRepository
    
    private(set) var isLoading: Bool = false {
        didSet { onLoadingChange?(isLoading)}
    }
    private(set) var shouldPaginate = false
    private var currentPage = 1
    
    var onLoadingChange: ((Bool) -> Void)?
    var onStateChange: ((SearchState) -> Void)?
    
    init(repository: SearchMovieRepository = SearchMovieRepository()) {
        self.repository = repository
    }
    
    enum SearchState {
        case success
        case failure(String)
        case cleared
    }
    
    func requestSearchMovie(query: String) {
        if isValidQuery(query: query) {
            isLoading = true
            searchMovieService.requestSearchMovie(query: query, page: currentPage) { [weak self] response in
                guard let self = self else {
                    return
                }
                self.isLoading = false
                
                switch response {
                case .success(let result):
                    if !shouldPaginate {
                        self.moviesResponse = result
                    } else {
                        self.moviesResponse?.results.append(contentsOf: result.results)
                    }
                    
                    shouldPaginate = !result.results.isEmpty
                    if shouldPaginate { currentPage += 1 }
                   
                    let isEmpty = self.moviesResponse?.results.isEmpty ?? true
                    self.onStateChange?(isEmpty ? .failure("No movies found") : .success)
                case .failure(let error):
                    switch error {
                    case .failedToParse, .invalidURL, .invalidData, .invalidResponse, .unableToComplete:
                        self.onStateChange?(.failure("Unable to load data"))
                    case .noInternet:
                        self.onStateChange?(.failure("Internet connection is not available"))
                    }
                }
            }
        }
        else {
            moviesResponse = nil
            self.onStateChange?(.cleared)
        }
    }
    
    func resetPagination() {
        currentPage = 1
        shouldPaginate = false
    }
    
    func fetchRecentSearch() {
        let recentMovies = repository.fetchSearchMovie()
        if !recentMovies.isEmpty {
            moviesResponse = MovieResponseModel(page: 1, results: recentMovies)
            self.onStateChange?(.success)
        }
    }
    
    private func isValidQuery(query: String) -> Bool {
        return !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

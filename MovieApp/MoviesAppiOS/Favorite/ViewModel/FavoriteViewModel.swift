//
//  FavoriteViewModel.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

class FavoriteViewModel {
    private(set) var moviesResponse: MovieResponseModel?
    
    private let repository: FavoriteMovieRepository
    
    var onStateChange: ((BasicState) -> Void)?
    
    init(repository: FavoriteMovieRepository = FavoriteMovieRepository()) {
        self.repository = repository
    }
    
    func fetchFavoriteMovies() {
        let favMovies = repository.fetchFavoriteMovies()
        moviesResponse = MovieResponseModel(page: 1, results: favMovies)
        if (moviesResponse?.results ?? []).isEmpty {
            self.onStateChange?(.failure("No Favorite Movies"))
        } else {
            self.onStateChange?(.success)
        }
    }
}

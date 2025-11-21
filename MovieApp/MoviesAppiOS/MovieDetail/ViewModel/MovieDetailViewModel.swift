//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

class MovieDetailViewModel {
    private(set) var movieDetailResponse: MovieDetailResponseModel?
    private let service = MovieDetailService()
    
    private let favoriteRepository: FavoriteMovieRepository
    
    private(set) var isLoading = false {
        didSet {onLoadingChange?(isLoading)}
    }
    
    var onLoadingChange: ((Bool) -> Void)?
    var onStateChange: ((BasicState) -> Void)?
    
    init(favoriteRepository: FavoriteMovieRepository = FavoriteMovieRepository()) {
        self.favoriteRepository = favoriteRepository
    }
    
    
    func requestMovieDetail(movieID: Int) {
        isLoading = true
        service.requestMovieDetail(movieID: movieID) { [weak self] response in
            guard let self = self else {
                return
            }
            
            self.isLoading = false
            
            switch response {
            case .success(let data):
                self.movieDetailResponse = data
                self.onStateChange?(.success)
            case .failure(let error):
                self.onStateChange?(.failure(error.localizedDescription))
            }
        }
    }
    
    func fetchDetailOffline(movieID: Int) {
        let favMovies = favoriteRepository.fetchFavoriteMovies(movieID: movieID)
        if !favMovies.isEmpty {
            let favMovie = favMovies.first
            movieDetailResponse = MovieDetailResponseModel(id: movieID,
                                                           backdrop_path: favMovie?.detail?.backdrop_path,
                                                           original_title: favMovie?.detail?.original_title,
                                                           overview: favMovie?.detail?.overview,
                                                           poster_path: favMovie?.detail?.poster_path,
                                                           release_date: favMovie?.detail?.release_date,
                                                           runtime: favMovie?.detail?.runtime,
                                                           status: favMovie?.detail?.status,
                                                           vote_average: favMovie?.detail?.vote_average,
                                                           title: favMovie?.detail?.title)
            
            self.onStateChange?(.success)
        } else {
            self.onStateChange?(.failure("No detail found"))
        }
    }
    
    func toggleFavorite(movie: MovieModel) -> Bool {
        if let movieDetailResponse = movieDetailResponse {
            let status = favoriteRepository.saveFavoriteMovies(movie: movie, movieDetail: movieDetailResponse)
            return status.0
        }
        return false
    }
    
    func isMovieFavorite(movieID: Int) -> Bool {
        return favoriteRepository.isMovieAvailableInFavorite(movieID: movieID)
    }
}

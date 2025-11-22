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
    private let searchRepository: SearchMovieRepository
    
    private(set) var isLoading = false {
        didSet {onLoadingChange?(isLoading)}
    }
    
    var onLoadingChange: ((Bool) -> Void)?
    var onStateChange: ((BasicState) -> Void)?
    
    init(favoriteRepository: FavoriteMovieRepository = FavoriteMovieRepository(), searchRepository: SearchMovieRepository = SearchMovieRepository()) {
        self.favoriteRepository = favoriteRepository
        self.searchRepository = searchRepository
    }
    
    
    func requestMovieDetail(movie: MovieModel) {
        isLoading = true
        service.requestMovieDetail(movieID: movie.id) { [weak self] response in
            guard let self = self else {
                return
            }
            
            self.isLoading = false
            
            switch response {
            case .success(let data):
                self.movieDetailResponse = data
                saveSearchMovie(movie: movie, movieDetail: data)
                self.onStateChange?(.success)
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
    
    func fetchFavoriteDetailOffline(movieID: Int) {
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
    
    func fetchRecentSeachMovieDetailOffline(movieID: Int) {
        let recentMovies = searchRepository.fetchSearchMovie(movieID: movieID)
        if !recentMovies.isEmpty {
            let searchMovie = recentMovies.first
            movieDetailResponse = MovieDetailResponseModel(id: movieID,
                                                           backdrop_path: searchMovie?.detail?.backdrop_path,
                                                           original_title: searchMovie?.detail?.original_title,
                                                           overview: searchMovie?.detail?.overview,
                                                           poster_path: searchMovie?.detail?.poster_path,
                                                           release_date: searchMovie?.detail?.release_date,
                                                           runtime: searchMovie?.detail?.runtime,
                                                           status: searchMovie?.detail?.status,
                                                           vote_average: searchMovie?.detail?.vote_average,
                                                           title: searchMovie?.detail?.title)
            self.onStateChange?(.success)
        }
        else {
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
    
    func saveSearchMovie(movie: MovieModel, movieDetail: MovieDetailResponseModel) {
        searchRepository.saveSearchMovies(movie: movie, movieDetail: movieDetail)
    }
    
    func isMovieFavorite(movieID: Int) -> Bool {
        return favoriteRepository.isMovieAvailableInFavorite(movieID: movieID)
    }
}

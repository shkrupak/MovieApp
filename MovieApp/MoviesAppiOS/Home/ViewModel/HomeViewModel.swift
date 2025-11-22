//
//  HomeServiceViewModel.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

final class HomeViewModel {
    private(set) var moviesResponse: MovieResponseModel?
    private let service = HomeService()
    private let repository: PopularMovieRepository
    
    private(set) var isLoading: Bool = false {
        didSet { onLoadingChange?( isLoading )}
    }
    
    var onLoadingChange: ((Bool) -> Void)?
    var onStateChange: ((BasicState) -> Void)?
    
    init(repository: PopularMovieRepository = PopularMovieRepository()) {
        self.repository = repository
    }
    
    func requestPopularMovie() {
        if Network.isNetworkAvailable() {
            isLoading = true
            service.requestPopularMovie { [weak self] response in
                guard let self = self else {
                    return
                }
                
                self.isLoading = false
                
                switch response {
                case .success(let result):
                    self.moviesResponse = result
                    repository.savePopularMovies(movies: moviesResponse?.results ?? [])
                    
                    let movies = repository.fetchPopularMovies()
                    print(movies.count)
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
        else {
            self.isLoading = false
            fetchMoviesFromCoreData()
        }
    }
    
    func fetchMoviesFromCoreData() {
        let movies = repository.fetchPopularMovies()
        moviesResponse = MovieResponseModel(page: 1, results: movies)
        if (self.moviesResponse?.results ?? []).isEmpty {
            self.onStateChange?(.failure("Seems like you are not connected to the internet. Please connect to internet and try again"))
        } else {
            self.onStateChange?(.success)
        }
    }
    
}

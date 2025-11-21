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
    private(set) var isLoading = false {
        didSet {onLoadingChange?(isLoading)}
    }
    
    var onLoadingChange: ((Bool) -> Void)?
    var onStateChange: ((BasicState) -> Void)?
    
    
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
    
    func toggleFavorite(movieID: Int) -> Bool {
        if var favorites = UserDefaults.standard.value(forKey: "favorites") as? [Int] {
            if favorites.contains(movieID) {
                favorites.removeAll { $0 == movieID }
                UserDefaults.standard.setValue(favorites, forKey: "favorites")
                return false
            }
            else {
                favorites.append(movieID)
                UserDefaults.standard.setValue(favorites, forKey: "favorites")
                return true
            }
        } else {
            var favorites: [Int] = []
            favorites.append(movieID)
            UserDefaults.standard.setValue(favorites, forKey: "favorites")
            return true
        }
    }
    
    func isMovieFavorite(movieID: Int) -> Bool {
        if let favorites = UserDefaults.standard.value(forKey: "favorites") as? [Int] {
            return favorites.contains(movieID)
        }
        return false
    }
}

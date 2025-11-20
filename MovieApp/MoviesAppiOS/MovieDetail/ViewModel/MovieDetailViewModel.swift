//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

class MovieDetailViewModel {
    var movieDetailResponse: MovieDetailResponseModel?
    private let service = MovieDetailService()
    var isLoading = false
    
    func requestMovieDetail(movieID: Int, completion: @escaping (Bool, String) -> Void) {
        isLoading = true
        service.requestMovieDetail(movieID: movieID) { [weak self] response in
            guard let self = self else {
                completion(false, "Unable to complete the request")
                return
            }
            
            self.isLoading = false
            
            switch response {
            case .success(let data):
                self.movieDetailResponse = data
                completion(true, "Movie detail received")
            case .failure(let error):
                completion(false, error.localizedDescription)
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
        if var favorites = UserDefaults.standard.value(forKey: "favorites") as? [Int] {
            return favorites.contains(movieID)
        }
        return false
    }
}

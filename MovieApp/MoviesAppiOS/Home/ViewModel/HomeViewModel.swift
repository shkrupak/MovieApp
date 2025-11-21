//
//  HomeServiceViewModel.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

class HomeViewModel {
    var moviesResponse: MovieResponseModel?
    private let service = HomeService()
    var isLoading: Bool = false
    
    
    func requestPopularMovie(completion: @escaping (Bool, String) -> Void) {
        isLoading = true
        service.requestPopularMovie { [weak self] response in
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

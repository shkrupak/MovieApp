//
//  HomeServiceViewModel.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

class HomeViewModel {
    private(set) var moviesResponse: MovieResponseModel?
    private let service = HomeService()
    private(set) var isLoading: Bool = false {
        didSet { onLoadingChange?( isLoading )}
    }
    
    var onLoadingChange: ((Bool) -> Void)?
    var onStateChange: ((BasicState) -> Void)?
    
    func requestPopularMovie() {
        isLoading = true
        service.requestPopularMovie { [weak self] response in
            guard let self = self else {
                return
            }
            
            self.isLoading = false
            
            switch response {
            case .success(let result):
                self.moviesResponse = result
                self.onStateChange?(.success)
            case .failure(let error):
                self.onStateChange?(.failure(error.localizedDescription))
            }
        }
    }
    
}

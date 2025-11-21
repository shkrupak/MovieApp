//
//  HomeServiceProtocol.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

protocol HomeServiceProtocol {
    func requestPopularMovie(completion: @escaping (Result<MovieResponseModel, RemoteAPIError>) -> Void)
}

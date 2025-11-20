//
//  MovieDetailServiceProtocol.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

protocol MovieDetailServiceProtocol {
    func requestMovieDetail(movieID: Int, completion: @escaping (Result<MovieDetailResponseModel, RemoteAPIError>) -> Void)
}

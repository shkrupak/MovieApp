//
//  SearchServiceProtocol.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

protocol SearchMovieServiceProtocol {
    func requestSearchMovie(query: String, page: Int, completion: @escaping (Result<MovieResponseModel, RemoteAPIError>) -> Void)
}

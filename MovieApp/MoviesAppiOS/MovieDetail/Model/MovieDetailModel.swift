//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

struct MovieDetailResponseModel: Decodable {
    let id: Int?
    let backdrop_path: String?
    let genres: [MovieGenre]?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let runtime: Int?
    let status: String?
    let vote_average: Double?
    let title: String?
}

struct MovieGenre: Decodable {
    let id: Int?
    let name: String?
}


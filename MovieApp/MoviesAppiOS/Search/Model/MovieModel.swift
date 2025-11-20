//
//  MovieModel.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation

struct MovieResponseModel: Decodable {
    let page: Int?
    var results: [MovieModel] = []
}

struct MovieModel: Decodable {
    let id: Int?
    let title: String?
    let release_date: String?
    let original_title: String?
}

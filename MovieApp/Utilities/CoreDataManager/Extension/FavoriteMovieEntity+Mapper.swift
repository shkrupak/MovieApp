//
//  FavoriteMovieEntity+Mapper.swift
//  MovieApp
//
//  Created by Rupak Shakya on 21/11/2025.
//

import Foundation

extension FavoriteMovieEntity {
    func populate(from movie: MovieModel, detail: Data) {
        id = Int64(movie.id)
        title = movie.title
        overview = movie.overview
        originalTitle = movie.original_title
        posterPath = movie.poster_path
        releaseDate = movie.release_date
        voteAverage = movie.vote_average ?? 0
        self.detail = detail
    }
    
    func toModel() -> MovieModel {
        MovieModel(
            id: Int(id),
            title: title ?? "",
            overview: overview ?? "",
            release_date: releaseDate ?? "",
            original_title: originalTitle ?? "",
            poster_path: posterPath ?? "",
            vote_average: voteAverage,
            detail: (try? JSONDecoder().decode(MovieDetailResponseModel.self, from: detail ?? Data()))
        )
    }
}

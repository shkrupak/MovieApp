//
//  PopularMovieEntity+Mapper.swift
//  MovieApp
//
//  Created by Rupak Shakya on 21/11/2025.
//

import Foundation

extension PopularMovieEntity {
    func populate(for movie: MovieModel, sortIndex: Int) {
        id = Int64(movie.id ?? 0)
        title = movie.title
        overview = movie.overview
        originalTitle = movie.original_title
        posterPath = movie.poster_path
        releaseDate = movie.release_date
        voteAverage = movie.vote_average ?? 0
        sortID = Int64(sortIndex)
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
            detail: nil
        )
    }
}

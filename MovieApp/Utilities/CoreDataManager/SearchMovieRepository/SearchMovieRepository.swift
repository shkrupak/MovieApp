//
//  SearchMovieRepository.swift
//  MovieApp
//
//  Created by Rupak Shakya on 21/11/2025.
//

import Foundation
import CoreData

final class SearchMovieRepository {
    
    private let context = CoreDataManager.shared.context
    
    //save
    func saveSearchMovies(movie: MovieModel, movieDetail: MovieDetailResponseModel) {
        let fetchRequest: NSFetchRequest<SearchMovieEntity> = SearchMovieEntity.fetchRequest()
        do {
            let searchMovieEntities = try context.fetch(fetchRequest)
            
            if let existingMovie = searchMovieEntities.first(where: { $0.id == movie.id }) {
                context.delete(existingMovie)
            }
            
            let movieDetailData = try JSONEncoder().encode(movieDetail)
            
            let searchMovieEntity = SearchMovieEntity(context: context)
            searchMovieEntity.populate(from: movie, detail: movieDetailData)
            
            do {
                try context.save()
            } catch {
                print("Save error: \(error)")
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //fetch
    func fetchSearchMovie(movieID: Int? = nil) -> [MovieModel] {
        let fetchRequest: NSFetchRequest<SearchMovieEntity> = SearchMovieEntity.fetchRequest()
        if let movieID {
            fetchRequest.predicate = NSPredicate(format: "id == %d", movieID)
            fetchRequest.fetchLimit = 1
        }
        do {
            let searchMovieEntities = try context.fetch(fetchRequest)
            return searchMovieEntities.map { searchMovieEntity in
                searchMovieEntity.toModel()
            }.reversed()
            
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
}

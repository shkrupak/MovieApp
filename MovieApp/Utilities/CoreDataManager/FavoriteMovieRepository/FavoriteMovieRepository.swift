//
//  FavoriteMovieRepository.swift
//  MovieApp
//
//  Created by Rupak Shakya on 21/11/2025.
//

import Foundation
import CoreData

final class FavoriteMovieRepository {
    
    private let context = CoreDataManager.shared.context
    
    func fetchFavoriteMovies(movieID: Int? = nil) -> [MovieModel] {
        let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
        if let movieID {
            fetchRequest.predicate = NSPredicate(format: "id CONTAINS %d", movieID)
        }
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "sortID", ascending: true)
        ]
        
        do {
            let favoriteMovieEntities = try context.fetch(fetchRequest)
            return favoriteMovieEntities.map { favoriteMovieEntity in
                favoriteMovieEntity.toModel()
            }
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func isMovieAvailableInFavorite(movieID: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movieID)
        fetchRequest.fetchLimit = 1
        do {
            let favoriteMovieEntities = try context.fetch(fetchRequest)
            return favoriteMovieEntities.first != nil
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    private func movieDetailDecoder(detail: Data?) -> MovieDetailResponseModel? {
        if let data = detail {
            do {
                return try JSONDecoder().decode(MovieDetailResponseModel.self, from: data)
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
    
    func saveFavoriteMovies(movie: MovieModel, movieDetail: MovieDetailResponseModel) -> (Bool, String) {
        let fetchRequest: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
        do {
            let favoriteMovieEntities = try context.fetch(fetchRequest)
            
            if let existingMovie = favoriteMovieEntities.first(where: { $0.id == movie.id }) {
                context.delete(existingMovie)
                return (false, "Favorite removed")
            } else {
                
                let movieDetailData = try JSONEncoder().encode(movieDetail)
                
                let favoriteMovieEntity = FavoriteMovieEntity(context: context)
                favoriteMovieEntity.populate(from: movie, detail: movieDetailData)
            }
            
            do {
                try context.save()
                return (true, "Favorite saved")
            } catch {
                print("Save error: \(error)")
                return (false, error.localizedDescription)
            }
            
        } catch let error {
            print(error.localizedDescription)
            return (false, "Unable to toggle favorite")
        }
    }
}

//
//  PopularMovieRepository.swift
//  MovieApp
//
//  Created by Rupak Shakya on 21/11/2025.
//

import Foundation
import CoreData

final class PopularMovieRepository {
    
    private let context = CoreDataManager.shared.context
    
    func fetchPopularMovies() -> [MovieModel] {
        let fetchRequest: NSFetchRequest<PopularMovieEntity> = PopularMovieEntity.fetchRequest()
        let sortByDescriptor = NSSortDescriptor(key: "sortID", ascending: true)
        fetchRequest.sortDescriptors = [sortByDescriptor]
        
        do {
            let popularMovieEntities = try context.fetch(fetchRequest)
            return popularMovieEntities.map { popularMovieEntity in
                popularMovieEntity.toModel()
            }
        }
        catch let error {
            print(error.localizedDescription)
            return []
        }
    }
    
    func savePopularMovies(movies: [MovieModel]) {
        deleteAllPopularMovies()
        
        for (index, movie) in movies.enumerated() {
            let popularMovieEntity = PopularMovieEntity(context: context)
            popularMovieEntity.populate(for: movie, sortIndex: index)
        }
        CoreDataManager.shared.saveContext()
    }
    
    func deleteAllPopularMovies() {
        let fetchRequest: NSFetchRequest<PopularMovieEntity> = PopularMovieEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<any NSFetchRequestResult>)
        
        do {
            try context.execute(deleteRequest)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

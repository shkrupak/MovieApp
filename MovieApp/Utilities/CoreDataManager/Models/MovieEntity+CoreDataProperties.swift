//
//  MovieEntity+CoreDataProperties.swift
//  
//
//  Created by Rupak Shakya on 21/11/2025.
//
//

public import Foundation
public import CoreData


public typealias MovieEntityCoreDataPropertiesSet = NSSet

extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var isFavorite: Bool
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var movieDetail: MovieDetailEntity?

}

//
//  MovieDetailEntity+CoreDataProperties.swift
//  
//
//  Created by Rupak Shakya on 21/11/2025.
//
//

public import Foundation
public import CoreData


public typealias MovieDetailEntityCoreDataPropertiesSet = NSSet

extension MovieDetailEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetailEntity> {
        return NSFetchRequest<MovieDetailEntity>(entityName: "MovieDetailEntity")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var id: Int64
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var runtime: Int64
    @NSManaged public var status: String?
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var movie: MovieEntity?

}

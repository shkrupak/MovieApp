//
//  SearchMovieEntity+CoreDataProperties.swift
//  
//
//  Created by Rupak Shakya on 21/11/2025.
//
//

public import Foundation
public import CoreData


public typealias SearchMovieEntityCoreDataPropertiesSet = NSSet

extension SearchMovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchMovieEntity> {
        return NSFetchRequest<SearchMovieEntity>(entityName: "SearchMovieEntity")
    }

    @NSManaged public var detail: Data?
    @NSManaged public var id: Int64
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var sortID: Int64
    @NSManaged public var title: String?
    @NSManaged public var voteAverage: Double

}

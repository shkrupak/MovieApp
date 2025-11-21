//
//  APIConstant.swift
//  
//
//  Created by Rupak Shakya on 20/11/2025.
//

import Foundation



struct APIConstant {
    struct MovieBaseURL {
        static let prod = "https://api.themoviedb.org/3/"
        static let dev = ""
    }
    
    static private let accessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZGFhMDZjYjU4MjM1OGIzY2NkYzNiNTgxMGViZjE1YSIsIm5iZiI6MTc2MzUzNjY2My44NCwic3ViIjoiNjkxZDZmMTc5OTMyMGRkNjc2ZmMxZTg0Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.wZIHqXTVpBjYNGhAvVOhU8FKy_JWwwctc_CgKhIW41g"
    
    //current base url
    static private let baseURL = MovieBaseURL.prod
    static private let imageBaseURL = "https://image.tmdb.org/t/p/w500/"
    
    struct Endpoints {
        static var movieSearch: String {APIConstant.baseURL + "search/movie"}
        static var movieDetail: String {APIConstant.baseURL + "movie/"}
        static var popularMovie: String {APIConstant.baseURL + "movie/popular"}//append movie id
    }
    
    static func getHeader() -> Headers {
        let header: [String: String] = [
            "accept": "application/json",
            "Authorization": accessToken
        ]
        return header
    }
    
    static func getImageBaseUrl() -> String {
        return APIConstant.imageBaseURL
    }
}



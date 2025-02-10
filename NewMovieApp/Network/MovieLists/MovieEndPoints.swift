//
//  MovieEndPoints.swift
//  NewMovieApp
//
//  Created by Shahmar on 08.01.25.
//

import Foundation

enum MovieEndPoints: String {
    case popular = "/popular"
    case nowPlaying = "/now_playing"
    case upcoming = "/upcoming"
    case topRated = "/top_rated"
    case search = "/search"
    
    static var mainPath: String {
        return "/movie"
    }
    
    var path: String {
        return MovieEndPoints.mainPath + self.rawValue
    }
}


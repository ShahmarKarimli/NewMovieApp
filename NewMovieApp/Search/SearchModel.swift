//
//  SearchModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import Foundation


struct SearchResponseModel: Codable {
    let page: Int?
    let results: [SearchModel]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct SearchModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    
    var posterFullPath: String? {
        NetworkManager.getFullImagePath(filePath: posterPath)
    }
    var titleName: String? {
        return title ?? ""
    }

    var releasedDate: String? {
        guard let releaseDate else { return nil }
        let components = releaseDate.split(separator: "-")
        return components.first.map { String($0) }
        
    }
}


extension SearchModel: SearchCellData {
    
    var releaseSearchDate: String {
        releasedDate ?? ""
    }
    
    var imageName: String {
        posterFullPath ?? ""
    }
    
    var name: String {
        titleName ?? ""
    }
    var ratingSearch: String? {
        if let voteAverage = voteAverage {
            return String(format: "%.1f", voteAverage)
        }
        return ""
    }
}





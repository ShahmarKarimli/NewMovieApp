//
//  DetailsModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import Foundation


struct MovieDetailsModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbId: String?
    let originCountry: [String]?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbId = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func imagePath(filePath: String?) -> String? {
        guard let filePath else {return nil}
        let baseUrl = "https://image.tmdb.org/t/p/"
        let size = "w342"
        return "\(baseUrl)\(size)\(filePath)"
    }
    
    var posterFullPath: String? {
        imagePath(filePath: posterPath)
    }
    
    var backdropFullPath: String? {
        imagePath(filePath: backdropPath)
    }
    
    var titleName: String? {
          return title ?? originalTitle
      }

      var genre: String? {
          return genres?.first?.name
      }

      var rating: Double? {
          return voteAverage
      }

      var releasedDate: String? {
         // return releaseDate
          guard let releaseDate else { return nil }
          let components = releaseDate.split(separator: "-")
          return components.first.map { String($0) }
      
      }
    
      var movieTime: String? {
              guard let runtime else { return nil }
              return "\(runtime) minutes"
      }
  
}


struct Genre: Codable {
    let id: Int?
    let name: String?
}

struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}




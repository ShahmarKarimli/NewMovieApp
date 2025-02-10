//
//  AccountStatesModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 12.01.25.
//

import Foundation

struct AccountStatesResponseModel: Codable {
    let id: Int?
    let favorite: Bool?
   // let rated: Rated?
    let watchlist: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case favorite = "favorite"
     //   case rated = "rated"
        case watchlist = "watchlist"
    }
}

struct Rated: Codable {
    let value: Double?

    enum CodingKeys: String, CodingKey {
        case value = "value"
    }
}

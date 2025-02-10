//
//  CastModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import Foundation

struct CastResponseModel: Codable {
    let id: Int?
    let cast: [CastModel]?
    let crew: [CastModel]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
        case crew = "crew"
    }
}

struct CastModel: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castId: Int?
    let character: String?
    let creditId: String?
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case gender = "gender"
        case id = "id"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case originalName = "original_name"
        case popularity = "popularity"
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character = "character"
        case creditId = "credit_id"
        case order = "order"
        case department = "department"
        case job = "job"
    }
    
    var profileImagePath: String? {
        NetworkManager.getFullImagePath(filePath: profilePath)
    }
    var personName: String? {
        name
    }
}

extension CastModel: CastCellData {
    var authorProfileName: String {
        personName ?? ""
    }
    
    var imageURL: String? {
        profileImagePath ?? ""
    }
    
    
}

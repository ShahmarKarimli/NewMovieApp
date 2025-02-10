//
//  ReviewModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import Foundation

struct ReviewResponseModel: Codable {
    let id, page: Int?
    let results: [ReviewModel]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct ReviewModel: Codable {
    let author: String?
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
    
    var avatarFullPath: String? {
        NetworkManager.getFullImagePath(filePath: authorDetails?.avatarPath)
    }

    var personName: String? {
        authorDetails?.name
    }

    var ratingReviews: Double? {
        authorDetails?.rating
    }
}


struct AuthorDetails: Codable {
    let name, username: String?
    let avatarPath: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}

extension ReviewModel: ReviewCellData {
    var authorName: String {
       personName ?? ""
    }
    
    var avatarURL: String? {
       avatarFullPath
    }
    
    var reviewContent: String {
        content ?? ""
    }
    
    var userRating: Double {
        ratingReviews ?? 0.0
    }
    
    
}

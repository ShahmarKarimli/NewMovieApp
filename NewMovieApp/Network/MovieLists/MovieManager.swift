//
//  MovieManager.swift
//  NewMovieApp
//
//  Created by Shahmar on 08.01.25.
//

import Foundation

class MovieManager {
    
    static let shared = MovieManager()
    
    private init() {}
    
    
    func getPopular(page: Int, completion: @escaping (NetworkResponse<MovieListModel>) -> Void) {
        let path = MovieEndPoints.popular.path
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: ["page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func getNowPlaying(page: Int, completion: @escaping (NetworkResponse<NowPlayingResponseModel>) -> Void) {
        let path = MovieEndPoints.nowPlaying.path
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: ["page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func getUpComing(page: Int, completion: @escaping (NetworkResponse<UpComingResponseModel>) -> Void) {
        let path = MovieEndPoints.upcoming.path
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: ["page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func getTopRated(page: Int, completion: @escaping (NetworkResponse<TopRatedResponseModel>) -> Void) {
        let path = MovieEndPoints.topRated.path
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: ["page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func movieSearchDetails(query: String, page: Int, completion: @escaping (NetworkResponse<SearchResponseModel>) -> Void) {
        let path = "/search/movie"
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: nil,
            body: nil,
            queryParams: ["query": query, "page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func movieDetails(movieId: Int, completion: @escaping (NetworkResponse<MovieDetailsModel>) -> Void) {
        let path = MovieEndPoints.mainPath
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: [movieId],
            body: nil,
            queryParams: nil)
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func movieReviewDetails(movieId: Int, page: Int, completion: @escaping
                            (NetworkResponse<ReviewResponseModel>) -> Void) {
        let path = MovieEndPoints.mainPath
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: [movieId, "reviews"],
            body: nil,
            queryParams: ["page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func movieCastDetails(movieId: Int, completion: @escaping (NetworkResponse<CastResponseModel>) -> Void) {
        let path = MovieEndPoints.mainPath
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: [movieId, "credits"],
            body: nil,
            queryParams: nil)
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func accountStates(movieId: Int, completion: @escaping (NetworkResponse<AccountStatesResponseModel>) -> Void) {
        let path = MovieEndPoints.mainPath
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: [movieId, "account_states"],
            body: nil,
            queryParams: nil)
        NetworkManager.shared.request(model: model, completion: completion)
    }
    func addRating(movieId: Int, rating: Double, completion: @escaping (NetworkResponse<CoreModel>) -> Void) {
        let model = NetworkRequestModel(
            path: MovieEndPoints.mainPath,
            method: .post,
            pathParams: [movieId, "rating"],
            body: ["value": rating],
            queryParams: nil)
        NetworkManager.shared.request(model: model, completion: completion)
    }
    
    func movieWatchListDetails(accountId: String, page: Int, completion: @escaping (NetworkResponse<WatchListResponseModel>) -> Void) {
        let path = "/account"
        let model = NetworkRequestModel(
            path: path,
            method: .get,
            pathParams: [accountId, "watchlist", "movies"],
            body: nil,
            queryParams: ["page": page])
        NetworkManager.shared.request(model: model, completion: completion)
    }
   
    
    func addToWatchList(movieId: Int, add: Bool, completion: @escaping (NetworkResponse<CoreModel>) -> Void) {
        let path = "/account"
        let model = NetworkRequestModel(
            path: path,
            method: .post,
            pathParams: ["Kerimli_023", "watchlist"],
            body: ["media_type": "movie", "media_id": movieId, "watchlist": add ],
            queryParams: nil)
        NetworkManager.shared.request(model: model, completion: completion)
    }
}


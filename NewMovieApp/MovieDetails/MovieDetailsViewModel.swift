//
//  MovieDetailsViewModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import Foundation


class MovieDetailsViewModel {
    enum ViewState {
        case loading
        case loaded
        case error(String)
        case reloadData
        case deleteRatingSuccess(String)
        case addRatingSuccess(String)
        case accountStates
    }
    var callBack: ((ViewState) -> Void)?
    
    var aboutMovieData: AboutMovieCellData?
    
    let movieId: Int
  
    
    private var movieDetailModel: MovieDetailsModel?
    
    
    private(set) var watchListState: Bool?
    
    var backImagePath: String? {
        movieDetailModel?.backdropFullPath
    }
    var posterImagePath: String? {
        movieDetailModel?.posterFullPath
    }
    var titleName: String? {
        movieDetailModel?.titleName
    }
    var releaseDate: String? {
        movieDetailModel?.releasedDate
    }
    var movieTime: String? {
        movieDetailModel?.movieTime
    }
    var genreMovie: String? {
        movieDetailModel?.genre
    }
    
    var ratingVote: String? {
        guard let movAverage = movieDetailModel?.rating else { return nil }
        return String(format: "%.1f", movAverage)
    }
    var overview: String? {
        return movieDetailModel?.overview
    }
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    func fetchData() {
        movieDetailsList()
        accountStates()
    }
    
    func movieDetailsList() {
        callBack?(.loading)
        MovieManager.shared.movieDetails(movieId: movieId, completion: {
            [weak self] response in
            guard let self else {return}
            self.callBack?(.loaded)
            switch response {
            case .success(let model):
                self.movieDetailModel = model
                self.callBack?(.reloadData)
            case .error(let model):
                self.callBack?(.error(model.errorMessage))
            }
        })
    }
    
    func accountStates() {
        callBack?(.loading)
        MovieManager.shared.accountStates(movieId: movieId, completion: {
            [weak self] response in
            guard let self else {return}
            self.callBack?(.loaded)
            switch response {
            case .success(let model):
                self.watchListState = model.watchlist
                self.callBack?(.accountStates)
            case .error(let model):
                self.callBack?(.error(model.errorMessage))
            }
        })
    }
    
    
    func movieAddRatingList(rating: Double) {
        callBack?(.loading)
        MovieManager.shared.addRating(movieId: movieId, rating: rating, completion: {
            [weak self] response in
            guard let self else {return}
            self.callBack?(.loaded)
            switch response {
            case .success(let model):
                if model.success == true {
                    self.callBack?(.addRatingSuccess(model.statusMessage ?? "") )
                }
            case .error(let model):
                self.callBack?(.error(model.errorMessage))
            }
        })
    }
    
    func addToDetailsWatchList() {
        guard let watchListState = watchListState else { return}
        callBack?(.loading)
        MovieManager.shared.addToWatchList(movieId: movieId, add: !watchListState , completion: {
            [weak self] response in
            guard let self else {return}
            switch response {
            case .success(let model):
                if model.success == true {
                    self.accountStates()
                    self.callBack?(.reloadData)// new
                }
            case .error(let model):
                self.callBack?(.loaded)
                self.callBack?(.error(model.errorMessage))
            }
        })
    }
}





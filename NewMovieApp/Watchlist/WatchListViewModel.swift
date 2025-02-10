//
//  WatchListViewModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 12.01.25.
//

import Foundation

class WatchListViewModel {
    enum ViewState {
        case loading
        case loaded
        case error(String)
        case reloadData
        case deleteRatingSuccess(String)
    }
    var callBack: ((ViewState) -> Void)?
    
    var  movieWatchListModel: [WatchListModel] = []
     
    var querySearch: String = ""
    
    var posterPaths: [String?] {
        movieWatchListModel.map { $0.posterFullPath}
    }
    
    var titlePersonNames: [String?] {
        movieWatchListModel.map { $0.titleName }
    }
    
    var ratingReviewVotes: [String?] {
        movieWatchListModel.map { guard let movSearchAverage = $0.ratingSearch else { return nil }
            return String(format: "%.1f", movSearchAverage) }
    }
    
    var releaseDateSearch: [String?] {
        movieWatchListModel.map { $0.releasedDate}
    }

    func movieWatchList() {
        callBack?(.loading)
        MovieManager.shared.movieWatchListDetails(accountId: "Kerimli_023", page: 1, completion: {
            [weak self] response in
            guard let self else { return }
            self.callBack?(.loaded)
            switch response {
            case .success(let model):
                self.movieWatchListModel = model.results ?? []
                self.callBack?(.reloadData)// new
            case .error(let model):
                self.callBack?(.error(model.errorMessage))
            }
        })
    }
}

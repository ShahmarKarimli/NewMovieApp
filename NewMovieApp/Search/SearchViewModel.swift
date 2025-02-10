////
////  SearchViewModel.swift
////  NewMovieApp
////
////  Created by Shahmar on 09.01.25.
////
//
//import Foundation
//
//class SearchViewModel {
//    enum ViewState {
//        case loading
//        case loaded
//        case error(String)
//        case reloadData
//        case deleteRatingSuccess(String)
//    }
//    var callBack: ((ViewState) -> Void)?
//    
//    var  movieSearchModel: [SearchModel] = []
//     
//    var querySearch: String = ""
//    
//    var posterPaths: [String?] {
//        movieSearchModel.map { $0.posterFullPath}
//    }
//    
//    var titlePersonNames: [String?] {
//        movieSearchModel.map { $0.titleName }
//    }
//    
//    var ratingReviewVotes: [String?] {
//        movieSearchModel.map { guard let movSearchAverage = $0.ratingSearch else { return nil }
//            return String(format: "%.1f", movSearchAverage) }
//    }
//    
//    var releaseDateSearch: [String?] {
//        movieSearchModel.map { $0.releasedDate}
//    }
//
//    func movieSearchList() {
//        callBack?(.loading)
//        MovieManager.shared.movieSearchDetails(query: querySearch, page: 1, completion: {
//            [weak self] response in
//            guard let self else { return }
//            self.callBack?(.loaded)
//            switch response {
//            case .success(let model):
//                self.movieSearchModel = model.results ?? []
//                self.callBack?(.reloadData)
//            case .error(let model):
//                self.callBack?(.error(model.errorMessage))
//            }
//        })
//
//    }
//}

import Foundation

class SearchViewModel {
    enum ViewState {
        case loading
        case loaded
        case error(String)
        case reloadData
        case deleteRatingSuccess(String)
    }
    var callBack: ((ViewState) -> Void)?
    
    var movieSearchModel: [SearchModel] = []
    var querySearch: String = "" {
        didSet {
            searchWithDebounce()
        }
    }
    
    private var debounceTimer: Timer?
    
    var posterPaths: [String?] {
        movieSearchModel.map { $0.posterFullPath }
    }
    
    var titlePersonNames: [String?] {
        movieSearchModel.map { $0.titleName }
    }
    
    var ratingReviewVotes: [String?] {
        movieSearchModel.map {
            guard let movSearchAverage = $0.ratingSearch else { return nil }
            return String(format: "%.1f", movSearchAverage)
        }
    }
    
    var releaseDateSearch: [String?] {
        movieSearchModel.map { $0.releasedDate }
    }
    
    private func searchWithDebounce() {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.movieSearchList()
        }
    }

    func movieSearchList() {
        guard !querySearch.isEmpty else {
            movieSearchModel = []
            callBack?(.reloadData)
            return
        }
        
        callBack?(.loading)
        MovieManager.shared.movieSearchDetails(query: querySearch, page: 1, completion: { [weak self] response in
            guard let self else { return }
            self.callBack?(.loaded)
            switch response {
            case .success(let model):
                self.movieSearchModel = model.results ?? []
                self.callBack?(.reloadData)
            case .error(let model):
                self.callBack?(.error(model.errorMessage))
            }
        })
    }
}

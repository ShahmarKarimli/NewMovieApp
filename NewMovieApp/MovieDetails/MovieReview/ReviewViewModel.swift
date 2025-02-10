//
//  ReviewViewModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//
import Foundation


class ReviewViewModel {
    enum ViewState {
        case loading
        case loaded
        case error(String)
        case reloadData
        case deleteRatingSuccess(String)
    }
    var callBack: ((ViewState) -> Void)?
    
    var  movieReviewModel: [ReviewModel] = []
    
    let movieId: Int
   
    
    var avatarImagePaths: [String?] {
        movieReviewModel.map { $0.avatarFullPath }
    }
    
    var titlePersonNames: [String?] {
        movieReviewModel.map { $0.personName }
    }
    
    var ratingReviewVotes: [String?] {
        movieReviewModel.map { guard let movRevAverage = $0.ratingReviews else { return nil }
            return String(format: "%.1f", movRevAverage) }
    }
    
    var overviewReviews: [String?] {
        movieReviewModel.map { $0.reviewContent }
    }
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func movieReviewsList() {
        callBack?(.loading)
        MovieManager.shared.movieReviewDetails(movieId: movieId, page: 1, completion: {
            [weak self] response in
            guard let self else { return }
            self.callBack?(.loaded)
            switch response {
            case .success(let model):
                self.movieReviewModel = model.results ?? []
                self.callBack?(.reloadData)
            case .error(let model):
                self.callBack?(.error(model.errorMessage))
            }
        })
    }
    
}
  




    
   
    
    
    



//
//  CastViewModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import Foundation

class CastViewModel {
    enum ViewState {
        case loading
        case loaded
        case error(String)
        case reloadData
        case deleteRatingSuccess(String)
    }
    var callBack: ((ViewState) -> Void)?
    
    var  movieCastModel: [CastModel] = []
    
    let movieId: Int
    
    var profileImagePaths: [String?] {
        movieCastModel.map { $0.profileImagePath}
    }
    
    var titlePersonNames: [String?] {
        movieCastModel.map { $0.personName }
    }
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func movieCastList() {
        callBack?(.loading)
        MovieManager.shared.movieCastDetails(movieId: movieId, completion: {
            [weak self] response in
            guard let self else { return }
            self.callBack?(.loaded)
            switch response {
            case .success(let model):
                self.movieCastModel = model.cast ?? []
                self.callBack?(.reloadData)
            case .error(let model):
                self.callBack?(.error(model.errorMessage))
            }
        })

    }
}

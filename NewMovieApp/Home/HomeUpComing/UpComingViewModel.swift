//
//  UpComingViewModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 10.01.25.
//

import Foundation

class UpComingViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case error(String)
        case reloadData
    }
    var callBack: ((ViewState) -> Void)?
    
    var page: Int = 0
    var movieList: [UpComingModel] = []
    
    var numberOfItems: Int {
        movieList.count
    }
    
    func movieImagePath(index: Int) -> String? {
        movieList[index].movieImageFullPath
    }
    
    func getUpComingMovieList() {
        callBack?(.loading)
        MovieManager.shared.getUpComing(page: 1, completion: {
            [weak self] response in
            guard let self else { return }
            callBack?(.loaded)
            switch response {
            case .success(let model):
                self.page = model.page ?? 0
                self.movieList = model.results ?? []
                self.callBack?(.reloadData)
            case .error(let model):
                self.callBack?(.error(model.errorMessage))
            }
        })
    }
    
    
}

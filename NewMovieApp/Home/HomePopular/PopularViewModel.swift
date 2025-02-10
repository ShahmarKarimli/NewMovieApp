//
//  PopularViewModel.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import Foundation



class PopularViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case error(String)
        case reloadData
    }
    var callBack: ((ViewState) -> Void)?
    
     var page: Int = 0
     var movieList: [PopularModel] = []
    
    var numberOfItems: Int {
        movieList.count
    }
    
    func movieImagePath(index: Int) -> String? {
        movieList[index].movieImageFullPath
    }
  
   
    func getPopularMovieList() {
        callBack?(.loading)
        MovieManager.shared.getPopular(page: 1, completion: {
            [weak self] response in
            guard let self else {return}
            self.callBack?(.loaded)
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

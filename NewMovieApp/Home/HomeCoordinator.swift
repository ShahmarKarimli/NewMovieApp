//
//  HomeCoordinator.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import UIKit

protocol HomeCoordinator: UIViewController {
   
    
    func showMovieDetailsController(movieId: Int)
    
}

extension HomeCoordinator {
    func showMovieDetailsController(movieId: Int) {
        let controller = MovieDetailsController(viewModel: MovieDetailsViewModel(movieId: movieId))
        navigationController?.show(controller, sender: nil)
    }
    
    func showRatingDetails(callBack: ((Double) -> Void)?) {
        let controller = RatingController()
        controller.callBack = callBack
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        navigationController?.present(controller, animated: true)
    }
    
   

}

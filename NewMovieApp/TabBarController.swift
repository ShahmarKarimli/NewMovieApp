//
//  TabBarController.swift
//  NewMovieApp
//
//  Created by Shahmar on 08.01.25.
//

import UIKit


class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .customTint
        tabBar.unselectedItemTintColor = .tabbarItemsColorCustom
        tabBar.backgroundColor = .backgroundColorCustom
        let homeController = HomeController()
        let searchController = SearchController(viewModel: SearchViewModel())
        let watchListController = WatchListController(viewModel: WatchListViewModel())
        viewControllers = [homeController, searchController, watchListController]
    }
}

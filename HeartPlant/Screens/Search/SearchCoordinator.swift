//
//  SearchCoordinator.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinator {
    let navigationController: UINavigationController
    private var searchViewController: SearchViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        
        setupNavigationControllerStyling()
    }
    
    override func start() {
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem.title = "Search"
        searchViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-search_filled")
        setDeallocallable(with: searchViewController)
        navigationController.pushViewController(searchViewController, animated: false)
        self.searchViewController = searchViewController
    }
    
    private func setupNavigationControllerStyling() {
        navigationController.navigationBar.prefersLargeTitles = true
    }
}

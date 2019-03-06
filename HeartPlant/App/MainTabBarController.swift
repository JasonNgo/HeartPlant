//
//  MainTabBarController.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Tab Bar Coordinators
    private let plantFeedCoordinator: PlantFeedCoordinator
    private let searchCoordinator: SearchCoordinator
    private let profileCoordinator: ProfileCoordinator

    // MARK: - Initializers
    init() {
        self.plantFeedCoordinator = PlantFeedCoordinator(navigationController: UINavigationController())
        self.searchCoordinator = SearchCoordinator(navigationController: UINavigationController())
        self.profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        setupCoordinators()
        setupTabBarViewControllers()
    }
    
    // MARK: - Setup
    private func setupTabBarController() {
        view.backgroundColor = .white
        tabBar.tintColor = ColorManager.shared.primaryColor
    }
    
    private func setupCoordinators() {
        plantFeedCoordinator.start()
        searchCoordinator.start()
        profileCoordinator.start()
    }
    
    private func setupTabBarViewControllers() {
        viewControllers = [
            plantFeedCoordinator.navigationController,
            searchCoordinator.navigationController,
            profileCoordinator.navigationController
        ]
    }
    
    // MARK: - Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


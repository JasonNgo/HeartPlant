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
    
    // MARK: - Data Source
    private let coreDataStack: CoreDataStack

    // MARK: - Initializers
    init() {
        self.coreDataStack = CoreDataStack(modelName: "HeartPlant")
        self.plantFeedCoordinator = PlantFeedCoordinator(navigationController: UINavigationController(), coreDataStack: coreDataStack)
        self.searchCoordinator = SearchCoordinator(navigationController: UINavigationController(), coreDataStack: coreDataStack)
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
    
    // MARK: - Core Data
    func shouldSaveContext() {
        coreDataStack.saveContext()
    }
    
    // MARK: - Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


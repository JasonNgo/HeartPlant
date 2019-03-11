//
//  PlantFeedCoordinator.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class PlantFeedCoordinator: Coordinator {
    let navigationController: UINavigationController
    // MARK: - Dependencies
    private let coreDataStack: CoreDataStack
    // MARK: - Root View Controller
    private var plantFeedViewController: PlantFeedViewController?
    // MARK: - Child Coordinators
    private var plantDetailCoordinator: PlantDetailCoordinator?
    private var searchCoordinator: SearchCoordinator?
    
    // MARK: - Initializer
    init(navigationController: UINavigationController, coreDataStack: CoreDataStack) {
        self.navigationController = navigationController
        self.coreDataStack = coreDataStack
        super.init()
        
        setupNavigationControllerStyling()
    }
    
    override func start() {
        let plantFeedDataSource = PlantFeedDataSource(coreDataStack: coreDataStack)
        let plantFeedViewController = PlantFeedViewController(dataSource: plantFeedDataSource)
        plantFeedViewController.delegate = self
        plantFeedViewController.tabBarItem.title = "Plants"
        plantFeedViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-potted_plant")
        setDeallocallable(with: plantFeedViewController)
        navigationController.pushViewController(plantFeedViewController, animated: false)
        self.plantFeedViewController = plantFeedViewController
    }
    
    // MARK: - Setup
    private func setupNavigationControllerStyling() {
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: ColorManager.shared.primaryColor
        ]
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = titleTextAttributes
    }
}

extension PlantFeedCoordinator: PlantFeedViewControllerDelegate {
    func plantFeedViewControllerDidPressSearch() {
        let searchNavController = UINavigationController()
        let searchCoordinator = SearchCoordinator(navigationController: searchNavController, coreDataStack: coreDataStack)
        searchCoordinator.stop = { [weak self] in
            self?.searchCoordinator = nil
        }
        searchCoordinator.start()
        self.navigationController.present(searchNavController, animated: true)
        self.searchCoordinator = searchCoordinator
    }
    
    func plantFeedViewController(_ plantFeedController: PlantFeedViewController, didSelectItem item: Plant) {
//        let plantDetailCoordinator = PlantDetailCoordinator(navigationController: navigationController, plant: item, CoreDataStack)
//        plantDetailCoordinator.stop = { [weak self] in
//            self?.plantDetailCoordinator = nil
//        }
//        plantDetailCoordinator.start()
//        self.plantDetailCoordinator = plantDetailCoordinator
    }
}


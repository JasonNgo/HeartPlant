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
    // Dependencies
    private let coreDataStack: CoreDataStack
    // Root View Controller
    private var plantFeedViewController: PlantFeedViewController?
    // Child Coordinators
    private var plantDetailCoordinator: PlantDetailCoordinator?
    
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
    
    private func setupNavigationControllerStyling() {
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: ColorManager.shared.primaryColor
        ]
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = titleTextAttributes
    }
    
}

extension PlantFeedCoordinator: PlantFeedViewControllerDelegate {
    func plantFeedViewController(_ plantFeedController: PlantFeedViewController, didSelectItem item: Plant) {
//        let plantDetailCoordinator = PlantDetailCoordinator(navigationController: navigationController, plant: item, CoreDataStack)
//        plantDetailCoordinator.stop = { [weak self] in
//            self?.plantDetailCoordinator = nil
//        }
//        plantDetailCoordinator.start()
//        self.plantDetailCoordinator = plantDetailCoordinator
    }
}


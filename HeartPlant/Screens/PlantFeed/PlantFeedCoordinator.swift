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
    private var plantFeedViewController: PlantFeedViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        
        setupNavigationControllerStyling()
    }
    
    override func start() {
        let plantFeedDataSource = PlantFeedDataSource()
        let plantFeedViewController = PlantFeedViewController(dataSource: plantFeedDataSource)
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


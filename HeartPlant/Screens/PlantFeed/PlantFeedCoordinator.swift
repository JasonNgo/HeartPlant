//
//  PlantFeedCoordinator.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class PlantFeedCoordinator: Coordinator {
    private let navigationContrller: UINavigationController
    private var plantFeedViewController: PlantFeedViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationContrller = navigationController
    }
    
    override func start() {
        let plantFeedDataSource = PlantFeedDataSource()
        let plantFeedViewController = PlantFeedViewController(dataSource: plantFeedDataSource)
        setDeallocallable(with: plantFeedViewController)
        navigationContrller.pushViewController(plantFeedViewController, animated: false)
        self.plantFeedViewController = plantFeedViewController
    }
    
}


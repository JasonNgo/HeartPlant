//
//  PlantDetailCoordinator.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class PlantDetailCoordinator: Coordinator {
    let navigationController: UINavigationController
    private let plant: Plant
    private var plantDetailViewController: PlantDetailViewController?
    
    init(navigationController: UINavigationController, plant: Plant) {
        self.navigationController = navigationController
        self.plant = plant
        super.init()
    }
    
    override func start() {
        let plantDetailViewController = PlantDetailViewController(plant: plant)
        plantDetailViewController.title = plant.name
        setDeallocallable(with: plantDetailViewController)
        navigationController.pushViewController(plantDetailViewController, animated: true)
        self.plantDetailViewController = plantDetailViewController
    }

}

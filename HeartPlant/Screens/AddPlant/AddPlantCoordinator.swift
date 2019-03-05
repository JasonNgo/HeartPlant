//
//  AddPlantCoordinator.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class AddPlantCoordinator: Coordinator {
    let navigationController: UINavigationController
    private var addPlantViewController: AddPlantViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        
        setupNavigationControllerStyling()
    }
    
    override func start() {
        let addPlantViewController = AddPlantViewController()
        setDeallocallable(with: addPlantViewController)
        navigationController.pushViewController(addPlantViewController, animated: false)
        self.addPlantViewController = addPlantViewController
    }
    
    private func setupNavigationControllerStyling() {
        navigationController.navigationBar.isHidden = true
    }
}

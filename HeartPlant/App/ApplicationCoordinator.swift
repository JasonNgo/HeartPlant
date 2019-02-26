//
//  ApplicationCoordinator.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private var plantFeedCoordinator: PlantFeedCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        super.init()
    }
    
    override func start() {
        window.rootViewController = navigationController
        launchPlantFeedCoordinator()
        window.makeKeyAndVisible()
    }
    
    private func launchPlantFeedCoordinator() {
        let plantFeedCoordinator = PlantFeedCoordinator(navigationController: navigationController)
        plantFeedCoordinator.stop = { [weak self] in
            self?.plantFeedCoordinator = nil
        }
        plantFeedCoordinator.start()
        self.plantFeedCoordinator = plantFeedCoordinator
    }
}

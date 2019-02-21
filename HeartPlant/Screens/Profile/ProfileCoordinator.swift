//
//  ProfileCoordinator.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {
    let navigationController: UINavigationController
    private var profileViewController: ProfileViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        
        setupNavigationControllerStyling()
    }
    
    override func start() {
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem.title = "Profile"
        profileViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-user")
        setDeallocallable(with: profileViewController)
        navigationController.pushViewController(profileViewController, animated: false)
        self.profileViewController = profileViewController
    }
    
    private func setupNavigationControllerStyling() {
        navigationController.navigationBar.prefersLargeTitles = true
    }
}

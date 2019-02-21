//
//  ProfileVIewController.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Deinitcallable {
    
    // MARK: - Initializers
    
    var onDeinit: (() -> Void)?
    
    deinit {
        onDeinit?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllerStyling()
    }
    
    // MARK: - Setup
    
    private func setupControllerStyling() {
        title = "Profile"
        view.backgroundColor = .white
    }
    
}

//
//  AddPlantViewController.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class AddPlantViewController: UIViewController, Deinitcallable {
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add a Plant to your collection"
        return label
    }()
    
    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "name"
        return tf
    }()
    
    private let wateringDaysTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "watering days"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    // MARK: - Initializers
    
    var onDeinit: (() -> Void)?
    
    deinit {
        onDeinit?()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
    }
    
}

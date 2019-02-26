//
//  PlantFeedCellViewModel.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

struct PlantFeedCellViewModel {
    let nameText: String
}

extension PlantFeedCellViewModel {
    init(plant: Plant) {
        self.nameText = plant.name
    }
}

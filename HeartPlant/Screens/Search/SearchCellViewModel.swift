//
//  SearchCellViewModel.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

struct SearchCellViewModel {
    let nameText: String?
    let scientificNameText: String?
    
    init(plant: Plant) {
        self.nameText = plant.name
        self.scientificNameText = plant.scientificName
    }
}

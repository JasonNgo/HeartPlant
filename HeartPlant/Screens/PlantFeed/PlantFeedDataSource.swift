//
//  PlantFeedDataSource.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class PlantFeedDataSource: NSObject {
    
    private var plants: [Plant] = []
    
    var reuseId: String {
        return "PlantFeedCell"
    }
    
    func addPlant() {
//        let plant = Plant(name: "New Plant: \(plants.count + 1)")
//        plants.append(plant)
    }
}

extension PlantFeedDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? PlantFeedCell else {
            fatalError("Unable to dequeue PlantFeedCell")
        }
        
//        let plant = plants[indexPath.item]
//        let viewModel = PlantFeedCellViewModel(plant: plant)
//        cell.configureCell(using: viewModel)
        
        return cell
    }
}

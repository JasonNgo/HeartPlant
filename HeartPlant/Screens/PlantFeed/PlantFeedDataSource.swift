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
    private let coreDataStack: CoreDataStack
    
    var reuseId: String {
        return "PlantFeedCell"
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.plants = coreDataStack.fetchFavouritedPlantEntities()
        super.init()
    }
    
    func item(at index: Int) -> Plant? {
        guard !plants.isEmpty else {
            return nil
        }
        
        return plants[index]
    }
    

}

extension PlantFeedDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? PlantFeedCell else {
            fatalError("Unable to dequeue PlantFeedCell")
        }
        
        let plant = plants[indexPath.item]
        let viewModel = PlantFeedCellViewModel(plant: plant)
        cell.configureCell(using: viewModel)
        
        return cell
    }
}

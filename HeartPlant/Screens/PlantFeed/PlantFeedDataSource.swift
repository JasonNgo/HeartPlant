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
    
    var isEmpty: Bool {
        return plants.isEmpty
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        super.init()
        fetchItems()
    }
    
    func fetchItems() {
        self.plants = coreDataStack.fetchFavouritedPlantEntities()
    }
    
    func item(at index: Int) -> Plant? {
        guard !plants.isEmpty else {
            return nil
        }
        
        return plants[index]
    }
    
    func remove(at index: Int) throws {
        guard !isEmpty else {
            fatalError("Trying to remove from an empty feed")
        }
        
        guard let plant = item(at: index) else {
            return
        }
        
        do {
            try coreDataStack.managedContext.removePlantFromFavourited(plant: plant)
            plants.remove(at: index)
        } catch let error as NSError {
            throw error
        }
    }
}

// MARK: - UICollectionViewDataSource
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

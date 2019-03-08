//
//  SearchDataSource.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-03-06.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit
import CoreData

class SearchDataSource: NSObject {
    
    private var results: [Plant] = []
    private let coreDataStack: CoreDataStack

    var reuseId: String {
        return "SearchCell"
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        super.init()
        fetchAllPlantEntities()
    }
    
    func item(at index: Int) -> Plant? {
        guard !results.isEmpty else {
            return nil
        }
        
        return results[index]
    }
    
    func filterResults(with searchText: String) {
        guard !searchText.isEmpty else {
            fetchAllPlantEntities()
            return
        }
        
        let predicate = NSCompoundPredicate(
            type: .or,
            subpredicates: [
                NSPredicate(format: "name CONTAINS[c] '\(searchText)'"),
                NSPredicate(format: "scientificName CONTAINS[c] '\(searchText)'")
            ]
        )
        
        fetchAllPlantEntities(predicate: predicate)
    }
    
    private func fetchAllPlantEntities(predicate: NSPredicate? = nil) {
        let resultsFetch: NSFetchRequest<Plant> = Plant.fetchRequest()
        resultsFetch.predicate = predicate
        
        do {
            let results = try coreDataStack.managedContext.fetch(resultsFetch)
            self.results = results
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
        }
    }
}

extension SearchDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? SearchCell else {
            fatalError("Unable to dequeue search cell")
        }
        
        let searchResult = results[indexPath.item]
        let viewModel = SearchCellViewModel(plant: searchResult)
        cell.configureCell(using: viewModel)
        
        return cell
    }
}


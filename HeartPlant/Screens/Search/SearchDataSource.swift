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
        
        let resultsFetch: NSFetchRequest<Plant> = Plant.fetchRequest()
        let results = try! coreDataStack.managedContext.fetch(resultsFetch)
        
        if results.count > 0 {
            self.results = results
        } else {
            coreDataStack.setupPlantData()
        }
    }
    
    func item(at index: Int) -> Plant? {
        guard !results.isEmpty else {
            return nil
        }
        
        return results[index]
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



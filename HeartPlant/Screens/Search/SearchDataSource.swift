//
//  SearchDataSource.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-03-06.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class SearchDataSource: NSObject {
    private var results: [Plant] = []
    private let coreDataStack: CoreDataStack

    var reuseId: String {
        return "SearchCell"
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        super.init()
    }
    
    func item(at index: Int) -> Plant? {
        guard !results.isEmpty else {
            return nil
        }
        
        return results[index]
    }
    
    func fetchItems(completion: @escaping (Error?) -> Void) {
        do {
            try coreDataStack.fetchPlantEntities(completion: { [unowned self] (plants) in
                self.results = plants
                completion(nil)
            })
        } catch let error {
            completion(error)
        }
    }
    
    func filterResults(with searchText: String, completion: @escaping (Error?) -> Void) {
        if searchText.isEmpty {
            fetchItems(completion: completion)
            return
        }
        
        do {
            try coreDataStack.fetchPlantEntities(with: searchText) { [unowned self] (plants) in
                self.results = plants
                completion(nil)
            }
        } catch let error {
            completion(error)
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


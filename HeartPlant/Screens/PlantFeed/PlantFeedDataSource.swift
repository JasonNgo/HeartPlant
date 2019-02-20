//
//  PlantFeedDataSource.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class PlantFeedDataSource: NSObject {
    var reuseId: String {
        return "PlantFeedCell"
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
        
        return cell
    }
}

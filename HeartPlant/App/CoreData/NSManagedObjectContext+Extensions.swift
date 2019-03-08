//
//  NSManagedObjectContext+Extensions.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-03-07.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func updatePlantFavourited(to isFavourited: Bool, for plant: Plant) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Plant")
        fetchRequest.predicate = NSPredicate(format: "name = %@", plant.name ?? "")
        
        do {
            let results = try self.fetch(fetchRequest)
            if results.count > 0 {
                let resultsData = results as! [Plant]
                let object = resultsData.first!
                object.setValue(plant.isFavourited, forKey: "isFavourited")
                
                try self.save()
                
                return true
            }
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
        }
        
        return false
    }
}

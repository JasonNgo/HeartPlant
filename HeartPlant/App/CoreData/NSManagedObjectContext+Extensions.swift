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
    func updatePlantFavourited(to isFavourited: Bool, for plant: Plant) throws {
        do {
            try updatePlantFavouritedProperty(to: isFavourited, for: plant, shouldNotify: true)
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
            throw error
        }
    }
    
    func removePlantFromFavourited(plant: Plant) throws {
        do {
            try updatePlantFavouritedProperty(to: false, for: plant, shouldNotify: false)
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
            throw error
        }
    }
    
    private func updatePlantFavouritedProperty(to isFavourited: Bool, for plant: Plant, shouldNotify: Bool) throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Plant")
        fetchRequest.predicate = NSPredicate(format: "name = %@", plant.name ?? "")
        
        do {
            let results = try self.fetch(fetchRequest)
            if results.count > 0 {
                let resultsData = results as! [Plant]
                let object = resultsData.first!
                object.setValue(false, forKey: "isFavourited")
                
                try self.save()
                
                if shouldNotify {
                    NotificationCenter.default.post(name: PlantFeedViewController.updateFavouritesNotificationName, object: nil)
                }
            }
        } catch let error as NSError {
            throw error
        }
    }
}

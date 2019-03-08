//
//  CoreDataStack.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-03-06.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let modelName: String
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error: \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    // MARK: - Init
    init(modelName: String) {
        self.modelName = modelName
        setupPlantData()
    }
    
    // MARK: - Setup
    func setupPlantData() {
        let resultsFetch: NSFetchRequest<Plant> = Plant.fetchRequest()
        let count = try! managedContext.count(for: resultsFetch)
        if count > 0 { return }
        
        let path = Bundle.main.path(forResource: "plants", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        
        for dict in dataArray {
            let entity = NSEntityDescription.entity(forEntityName: "Plant", in: managedContext)!
            let plant = Plant(entity: entity, insertInto: managedContext)
            let plantDict = dict as! [String: Any]
            
            plant.name = plantDict["name"] as? String
            plant.scientificName = plantDict["scientificName"] as? String
            plant.isFavourited = plantDict["isFavourited"] as! Bool
        }
        
        saveContext()
    }
    
    func fetchPlantEntries(with searchText: String? = nil) -> [Plant] {
        let resultsFetch: NSFetchRequest<Plant> = Plant.fetchRequest()
        
        if searchText != nil {
            let predicate = NSCompoundPredicate(
                type: .or,
                subpredicates: [
                    NSPredicate(format: "name CONTAINS[c] '\(searchText!)'"),
                    NSPredicate(format: "scientificName CONTAINS[c] '\(searchText!)'")
                ]
            )
            resultsFetch.predicate = predicate
        } else {
            resultsFetch.predicate = nil
        }
        
        do {
            let results = try managedContext.fetch(resultsFetch)
            return results
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    func fetchFavouritedPlantEntities() -> [Plant] {
        let favouritesFetch: NSFetchRequest<Plant> = NSFetchRequest(entityName: "Plant")
        favouritesFetch.predicate = NSPredicate(format: "isFavourited == %@", NSNumber(booleanLiteral: true))
        
        do {
            let results = try managedContext.fetch(favouritesFetch)
            return results
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
        }
    }
    
    //    func clearAllPlantEntries() {
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plant")
    //        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    //        do {
    //            try storeContainer.persistentStoreCoordinator.execute(deleteRequest, with: managedContext)
    //        } catch let error as NSError {
    //            print("Unresolved error: \(error), \(error.userInfo)")
    //        }
    //    }
}

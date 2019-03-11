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
    
    // MARK: - Async Calls
    private var asyncFetchRequest: NSAsynchronousFetchRequest<Plant>?
    
    // MARK: - Init
    init(modelName: String) {
        self.modelName = modelName
        
        do {
            try setupPlantData()
        } catch {
            fatalError("Unable to setup plant database")
        }
    }
    
    // MARK: - Setup
    func setupPlantData() throws {
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
        
        do {
            try saveContext()
        } catch let error {
            throw error
        }
    }
    
    // MARK: - Fetching
    func fetchPlantEntities(with searchText: String? = nil, completion: @escaping ([Plant]) -> Void) throws {
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
        
        asyncFetchRequest = NSAsynchronousFetchRequest<Plant>(fetchRequest: resultsFetch) { (results: NSAsynchronousFetchResult) in
            guard let plants = results.finalResult else {
                return
            }
            
            completion(plants)
        }
        
        do {
            guard let asyncFetchRequest = asyncFetchRequest else {
                return
            }
            
            try managedContext.execute(asyncFetchRequest)
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
            throw error
        }
    }
    
    func fetchFavouritedPlantEntities(completion: @escaping ([Plant]) -> Void) throws {
        let favouritesFetch: NSFetchRequest<Plant> = NSFetchRequest(entityName: "Plant")
        favouritesFetch.predicate = NSPredicate(format: "isFavourited == %@", NSNumber(booleanLiteral: true))
        
        asyncFetchRequest = NSAsynchronousFetchRequest<Plant>(fetchRequest: favouritesFetch) { (results: NSAsynchronousFetchResult) in
            guard let favourites = results.finalResult else {
                return
            }

            completion(favourites)
        }

        do {
            guard let asyncFetchRequest = asyncFetchRequest else {
                return
            }

            try managedContext.execute(asyncFetchRequest)
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
            throw error
        }
    }
    
    // MARK: - Saving
    func saveContext() throws {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
            print("mangaedContext successfully updated")
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
            throw error
        }
    }
    
    func clearAllPlantEntries() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plant")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try storeContainer.persistentStoreCoordinator.execute(deleteRequest, with: managedContext)
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
        }
    }
}

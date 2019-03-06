//
//  Plant+CoreDataProperties.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-03-06.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//
//

import Foundation
import CoreData


extension Plant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plant> {
        return NSFetchRequest<Plant>(entityName: "Plant")
    }

    @NSManaged public var name: String?
    @NSManaged public var scientificName: String?
    @NSManaged public var isFavourited: Bool

}

//
//  FileAccessor.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-03-05.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import Foundation

class FileAccessor {
    static func getPlantsData() -> Data {
        do {
            let url = Bundle.main.url(forResource: "plants", withExtension: "json")
            let data = try Data(contentsOf: url!)
            return data
        } catch {
            fatalError("Error fetching plants from bundle")
        }
    }
}

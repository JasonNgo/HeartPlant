//
//  Plant.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import Foundation

struct Plant {
    let name: String
    let scientificName: String
}

extension Plant: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case scientificName = "scientific_name"
    }
}

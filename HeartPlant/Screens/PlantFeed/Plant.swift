//
//  Plant.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import Foundation

struct Plant {
    let id: Int
    let name: String
    let scientificName: String

//    let family: String
//    let light: String
//    let position: String
//    let temperatureRange: String
//    let watering: String
//    let seasonalCare: String
//    let feeding: String
//    let soil: String
}

extension Plant: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case scientificName = "scientific_name"
//        case family
//        case light
//        case position
//        case temperatureRange
//        case watering
//        case seasonalCare
//        case feeding
//        case soil
    }
}

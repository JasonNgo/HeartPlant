//
//  USDAPlantsEndPoint.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import Foundation

public enum USDAPlantsEndPoint {
    case species(_ species: String)
    case genus(_ genus: String)
    case name(_ name: String)
}

extension USDAPlantsEndPoint: EndPointType {
    var baseUrl: URL {
        guard let baseUrl = URL(string: "https://plantsdb.xyz/") else {
            fatalError("Unable to build base url")
        }
        
        return baseUrl
    }
    
    var path: String {
        return "search"
    }
    
    var httpMethod: HTTPMethod {
        return .GET
    }
    
    var task: HTTPTask {
        var urlParameters: Parameters = [:]
        urlParameters["fields"] = searchFields
        
        switch self {
        case .species(let specie):
            urlParameters["species"] = specie
        case .genus(let genus):
            urlParameters["genus"] = genus
        case .name(let name):
            urlParameters["common_name"] = name
        }
        
        return .requestParameters(urlParameters: urlParameters, bodyParameters: nil)
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

extension USDAPlantsEndPoint {
    private enum SearchFields: String, CaseIterable {
        case id = "id"
        case genus = "Genus"
        case species = "Species"
        case commonName = "Common_Name"
    }
    
    var searchFields: String {
        var output = ""
        SearchFields.allCases.forEach { output += "\($0.rawValue)," }
        output.removeLast()
        return output
    }
}

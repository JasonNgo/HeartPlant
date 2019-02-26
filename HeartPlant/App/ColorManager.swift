//
//  ColorManager.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class ColorManager {
    
    private init() {}
    static let shared = ColorManager()
    
    var primaryColor: UIColor {
        return UIColor(r: 31, g: 198, b: 178)
    }
    
}

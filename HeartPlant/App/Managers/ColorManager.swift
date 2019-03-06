//
//  ColorManager.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

enum ColorMode {
    case lightMode
    case darkMode
}

class ColorManager {
    
    private var mode: ColorMode = .lightMode
    static let shared = ColorManager()
    
    private init() {}
    
    var primaryColor: UIColor {
        switch mode {
        case .lightMode:
            return UIColor(r: 31, g: 198, b: 178)
        case .darkMode:
            return UIColor(r: 31, g: 198, b: 178)
        }
    }
    
    func switchMode() {
        if mode == .lightMode {
            mode = .darkMode
        } else {
            mode = .lightMode
        }
    }
    
}

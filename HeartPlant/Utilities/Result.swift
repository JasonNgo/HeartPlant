//
//  Result.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-03-11.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import Foundation

public enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

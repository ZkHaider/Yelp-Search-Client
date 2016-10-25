//
//  Coordinates.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/24/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation
import Mapper

struct Coordinates: Mappable {
    
    let longitude: Double?
    let latitude: Double?
    
    init(map: Mapper) throws {
        longitude       = map.optionalFrom("longitude")
        latitude        = map.optionalFrom("latitude")
    }
    
}

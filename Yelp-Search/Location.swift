//
//  Location.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/24/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation
import Mapper

struct Location: Mappable {
    
    let zipCode: String?
    let state: String?
    let country: String?
    let city: String?
    let address1: String?
    let address2: String?
    let address3: String?
    
    init(map: Mapper) throws {
        zipCode         = map.optionalFrom("zip_code")
        state           = map.optionalFrom("state")
        country         = map.optionalFrom("country")
        city            = map.optionalFrom("city")
        address1        = map.optionalFrom("address1")
        address2        = map.optionalFrom("address2")
        address3        = map.optionalFrom("address3")
    }
    
}

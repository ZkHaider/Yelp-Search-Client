//
//  Category.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/24/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation
import Mapper

struct Category: Mappable {
    
    let alias: String?
    let title: String?
    
    init(map: Mapper) throws {
        alias       = map.optionalFrom("alias")
        title       = map.optionalFrom("title")
    }
    
}

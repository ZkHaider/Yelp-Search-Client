//
//  AccessToken.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/23/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation
import Mapper

struct AccessToken: Mappable {
    
    let accessToken: String?
    let tokenType: String?
    let expiresIn: Int
    
    init(map: Mapper) throws {
        accessToken         = map.optionalFrom("access_token")
        tokenType           = map.optionalFrom("token_type")
        try expiresIn       = map.from("expires_in")
    }
    
    
}

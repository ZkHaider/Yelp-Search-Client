//
//  StringExtensions.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/29/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation

extension String {
    
    func join<S: Sequence>(elements: S) -> String {
        return elements.map{String(describing: $0)}.joined(separator: self)
    }
    
}

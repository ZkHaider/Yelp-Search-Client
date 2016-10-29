//
//  YelpCellType.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/28/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import Foundation

protocol YelpCellDelegate {
    func expandType(cellType: YelpCellType)
}

enum YelpCellType {
    case Sort
    case Distance
    case Category
}

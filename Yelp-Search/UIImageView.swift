//
//  UIImageView.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/24/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit
import KFSwiftImageLoader

extension UIImageView {
    
    public func setImageFromURLString(urlString: String) {
        
        self.alpha = 0.0
        
        // Build URL String
        self.loadImage(url: URL(string: urlString)!, placeholderImage: nil, completion: { (bool, error) in
            
            if error != nil {
                return
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 1.0
            })
        })
    }
    
}

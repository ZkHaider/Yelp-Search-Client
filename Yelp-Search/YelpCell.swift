//
//  YelpCell.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/23/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit

class YelpCell: UITableViewCell {

    @IBOutlet weak var yelpTitle: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var yelpMainImage: UIImageView! 
    @IBOutlet weak var starsImage: UIImageView!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var yelpTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    func updateWithBusiness(business: Business) {
        
        if business.name != nil {
            self.yelpTitle.text = business.name
        }
        
        if business.distance != nil {
            self.distanceLabel.text = business.distance
        }
        
        if business.imageURL != nil {
            self.yelpMainImage.layer.cornerRadius = 4.0
            self.yelpMainImage.loadImage(url: business.imageURL!)
        }
        
        if business.ratingImageURL != nil {
            self.starsImage.loadImage(url: business.ratingImageURL!)
        }
        
        if business.price != nil {
            self.priceLabel.text = business.price
        }
        
        if business.address != nil {
            self.addressLabel.text = business.address
        }
        
        if business.categories != nil {
            self.yelpTypeLabel.text = business.categories
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

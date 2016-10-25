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
    @IBOutlet weak var yelpMainImage: UIImageView! {
        didSet {
            self.yelpMainImage.layer.cornerRadius = 8.0
        }
    }
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
            self.yelpMainImage.loadImage(url: business.imageURL!)
        }
        
        if business.ratingImageURL != nil {
            self.starsImage.loadImage(url: business.ratingImageURL!)
        }
        
        if business.price != nil {
            self.priceLabel.text = business.price
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

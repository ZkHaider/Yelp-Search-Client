//
//  DealCell.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/28/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit

class DealCell: UITableViewCell {

    @IBOutlet weak var dealSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Check if deals is turned on
        let dealsOn = UserDefaultsWrapper.getBool(key: "deals", defaultValue: false)
        
        // Turn on deals if available 
        dealSwitch.setOn(dealsOn, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func dealPressed(_ sender: UISwitch) {
        
        let activated = sender.isOn
        if activated {
            UserDefaultsWrapper.setBool(key: "deals", value: true)
        } else {
            UserDefaultsWrapper.setBool(key: "deals", value: false)
        }
    }
    
}

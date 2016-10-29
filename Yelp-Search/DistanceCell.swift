//
//  DistanceCell.swift
//  Yelp-Search
//
//  Created by Haider Khan on 10/28/16.
//  Copyright © 2016 ZkHaider. All rights reserved.
//

import UIKit

class DistanceCell: UITableViewCell {

    @IBOutlet weak var expandButton: UIButton!
    
    private var delegate: YelpCellDelegate
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(delegate: YelpCellDelegate) {
        self.delegate = delegate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func expandPressed(_ sender: Any) {
        if delegate != nil {
            self.delegate.expandType(cellType: .Distance)
        }
    }
}

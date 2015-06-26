//
//  SearchTableViewCell.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var pastClassInstructorLabel: UILabel!
    @IBOutlet weak var pastDateCityLabel: UILabel!
    @IBOutlet weak var pastIntensityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

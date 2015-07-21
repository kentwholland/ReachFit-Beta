//
//  UpcomingTableViewCell.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/23/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    @IBOutlet weak var upcomingDateCityLabel: UILabel!
    @IBOutlet weak var upcomingClassInstructorLabel: UILabel!
    @IBOutlet weak var upcomingIntensityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

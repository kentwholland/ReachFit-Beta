//
//  UpcomingTableViewCell.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/23/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    @IBOutlet weak var dateAndCityLabel: UILabel!
    @IBOutlet weak var classAndInstructorLabel: UILabel!
    @IBOutlet weak var workoutIntensityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

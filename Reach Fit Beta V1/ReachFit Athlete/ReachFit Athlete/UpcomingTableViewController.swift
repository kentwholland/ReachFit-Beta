//
//  UpcomingTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class UpcomingTableViewController: UITableViewController {
    
    var currentUserSubscribed: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUserSubscribed = (CurrentUserInfo.currentUserSubscribedClasses as [String])
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("upcomingTableViewCellBox", forIndexPath: indexPath) as! UpcomingTableViewCell
        
        cell.upcomingClassInstructorLabel.text = "dfd"
        cell.upcomingDateCityLabel.text = "dkfj"
        cell.upcomingIntensityLabel.text = "1"
        
        return cell
    }
    
}

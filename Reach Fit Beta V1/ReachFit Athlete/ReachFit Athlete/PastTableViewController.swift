//
//  PastTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit

class PastTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var  cell:PastTableViewCell? = tableView.dequeueReusableCellWithIdentifier("upcomingTableViewCellBox") as? PastTableViewCell
        
        if cell == nil {
            let nib:Array = NSBundle.mainBundle().loadNibNamed("TableViewCell", owner: self, options: nil)
            cell = nib[0] as? PastTableViewCell
        }
        
        return cell!
    }

}

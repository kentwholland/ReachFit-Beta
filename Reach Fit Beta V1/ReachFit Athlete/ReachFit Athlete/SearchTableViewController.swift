//
//  SearchTableTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var  cell:SearchTableViewCell? = tableView.dequeueReusableCellWithIdentifier("upcomingTableViewCellBox") as? SearchTableViewCell
        
        if cell == nil {
            let nib:Array = NSBundle.mainBundle().loadNibNamed("TableViewCell", owner: self, options: nil)
            cell = nib[0] as? SearchTableViewCell
        }
        
        return cell!
    }

}

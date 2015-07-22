//
//  UpcomingTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class UpcomingTableViewController: PFQueryTableViewController {
    
    var stringDate: String = String()
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "WorkoutClasses"
        self.textKey = "workoutClassName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "WorkoutClasses")
        query.whereKey("dateOfClass", greaterThan: NSDate())
        query.whereKey("classStudents", equalTo: PFUser.currentUser()?.objectId! as String!)
        query.orderByAscending("workoutClassName")
        return query
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        var detailScene = segue.destinationViewController as! SearchDetailViewController
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let row = Int(indexPath.row)
            detailScene.currentObject = (objects?[row] as! PFObject)
        }
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        if let dateObject = object?["dateOfClass"] as? NSDate {
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm a"
            var dateNSDate: String = dateFormatter.stringFromDate(dateObject)
            stringDate = dateNSDate
            
        }
        
        // Extract values from the PFObject to display in the table cell
        if let nameEnglish = object?["workoutClassName"] as? String {
            
            if let instructorName = object?["instructorName"] as? String {
                
                cell?.textLabel?.text = "\(nameEnglish), \(instructorName)"
                
            }
            
        }
        if let capital = object?["locationOfClass"] as? String {
            
            cell?.detailTextLabel?.text = "\(capital), \(stringDate)"
            
        }
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Refresh the table to ensure any data changes are displayed
        tableView.reloadData()
        self.loadObjects()
    }
    
}

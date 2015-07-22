//
//  SearchTableTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class SearchTableViewController: PFQueryTableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
      
        super.init(style: style, className: className)
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCellBox") as! PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "SearchTableViewCellBox")
        }

        // Extract values from the PFObject to display in the table cell
        if let nameEnglish = object?["workoutClassName"] as? String {
            
            if let instructorName = object?["instructorName"] as? String {
                
                cell?.textLabel?.text = "\(nameEnglish), \(instructorName)"
                
            }

        }
        if let capital = object?["locationOfClass"] as? String {
            
            cell?.detailTextLabel?.text = "\(capital)"

        }
        
        return cell
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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "WorkoutClasses"
        self.textKey = "workoutClassName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
        self.loadObjects()
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        // Dismiss the keyboard
        searchBar.resignFirstResponder()
        
        // Force reload of table data
        self.loadObjects()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        // Dismiss the keyboard
        searchBar.resignFirstResponder()
        
        // Force reload of table data
        self.loadObjects()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        // Clear any search criteria
        searchBar.text = ""
        
        // Dismiss the keyboard
        searchBar.resignFirstResponder()
        
        // Force reload of table data
        self.loadObjects()
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "WorkoutClasses")

        if searchBar.text != "" {
            query.whereKey("searchText", containsString: searchBar.text.lowercaseString)
        }
        
        // Order the results
        query.orderByAscending("workoutClassName")
        
        // Return the qwuery object
        return query
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let objectToDelete = objects?[indexPath.row] as! PFObject
            objectToDelete.deleteInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // Force a reload of the table - fetching fresh data from Parse platform
                    self.loadObjects()
                } else {
                    // There was a problem, check error.description
                }
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
}

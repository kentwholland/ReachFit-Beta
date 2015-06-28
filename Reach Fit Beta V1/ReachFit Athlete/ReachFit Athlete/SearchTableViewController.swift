//
//  SearchTableTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class SearchTableViewController: UITableViewController {
    
    var indexPathOfClickedRow: Int = Int()
    
    // Class data intializer
    var workoutClassName: [String] = [String]()
    var instructorName: [String] = [String]()
    var workoutIntensity: [String] = [String]()
    var classMusicType: [String] = [String]()
    var dateOfClass: [String] = [String]()
    var locationOfClass: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        var query = PFQuery(className: "WorkoutClasses")
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {

                        self.workoutClassName.append(object.objectForKey("workoutClassName") as! String)
                        self.instructorName.append(object.objectForKey("instructorName") as! String)
                        self.workoutIntensity.append(object.objectForKey("workoutIntensity") as! String)
                        self.classMusicType.append(object.objectForKey("classMusicType") as! String)
                        self.dateOfClass.append(object.objectForKey("dateOfClass") as! String)
                        self.locationOfClass.append(object.objectForKey("locationOfClass") as! String)
                        
                        println(self.workoutClassName.count)
                        
                        self.tableView.reloadData()
                        
                    }
                    
                }
            } else {
                println("\(error?.userInfo)")
            }
        }
        
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        var query = PFQuery(className: "WorkoutClasses")
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    
                    self.workoutClassName = []
                    self.instructorName = []
                    self.workoutIntensity = []
                    self.classMusicType = []
                    self.dateOfClass = []
                    self.locationOfClass = []
                    
                    for object in objects {
                        
                        self.workoutClassName.append(object.objectForKey("workoutClassName") as! String)
                        self.instructorName.append(object.objectForKey("instructorName") as! String)
                        self.workoutIntensity.append(object.objectForKey("workoutIntensity") as! String)
                        self.classMusicType.append(object.objectForKey("classMusicType") as! String)
                        self.dateOfClass.append(object.objectForKey("dateOfClass") as! String)
                        self.locationOfClass.append(object.objectForKey("locationOfClass") as! String)
                        
                        self.tableView.reloadData()
                        
                        
                    }
                    
                    println("done")
                    refreshControl.endRefreshing()
                    
                }
            } else {
                println("\(error?.userInfo)")
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "GoToSearchDetailViewController" {
            
            var goingToViewController = segue.destinationViewController as! SearchDetailViewController
            goingToViewController.viewControllerTitle = "\(workoutClassName[indexPathOfClickedRow])"
            
        }
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        indexPathOfClickedRow = indexPath.row
        println(indexPathOfClickedRow)
        
        self.performSegueWithIdentifier("GoToSearchDetailViewController", sender: self)
        
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if workoutClassName.count == 0 {
            
            return 0
        } else {
            
            return workoutClassName.count
        }
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCellBox", forIndexPath: indexPath) as? SearchTableViewCell
        
        if workoutClassName.count >= 1 {
            
        cell?.searchClassInstructorLabel.text = "\(workoutClassName[indexPath.row]), \(instructorName[indexPath.row])"
        cell?.searchDateCityLabel.text = "\(dateOfClass[indexPath.row]), \(locationOfClass[indexPath.row])"
        cell?.searchIntensityLabel.text = "\(workoutIntensity[indexPath.row])"
            
        }
        
        return cell!
    }

}

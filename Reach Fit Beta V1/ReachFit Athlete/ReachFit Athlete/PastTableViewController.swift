//
//  PastTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class PastTableViewController: UITableViewController {
    
    var classesIds: [String] = [String]()
    
    // Class data intializer
    var workoutClassName: [String] = [String]()
    var instructorName: [String] = [String]()
    var workoutIntensity: [String] = [String]()
    var classMusicType: [String] = [String]()
    var dateOfClass: [String] = [String]()
    var locationOfClass: [String] = [String]()
    
    var filteredWorkoutClassName: [String] = [String]()
    var filteredInstructorName: [String] = [String]()
    var filteredWorkoutIntensity: [String] = [String]()
    var filteredDateOfClass: [String] = [String]()
    var filteredLocationOfClass: [String] = [String]()
    
    
    
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
                        self.classesIds.append(object.objectId! as String)
                        
                        println(self.workoutClassName.count)
                        println(self.classesIds.count)
                        println(self.instructorName)
                        
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
                        self.classesIds.append(object.objectId! as String)
                        
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return workoutClassName.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("pastTableViewCellBox") as? PastTableViewCell
        
        
        if self.classesIds.count > 0 {
            
            cell!.pastClassInstructorLabel.text = "\(workoutClassName[indexPath.row]), \(instructorName[indexPath.row])"
            cell!.pastDateCityLabel.text = "\(dateOfClass[indexPath.row]), \(locationOfClass[indexPath.row])"
            cell!.pastIntensityLabel.text = "\(workoutIntensity[indexPath.row])"
            
        }
        
        return cell!
        
    }
    
}

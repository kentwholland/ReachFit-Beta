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
    
    // Class data intializer
    var objectId: [String] = [String]()
    var workoutClassName: [String] = [String]()
    var instructorName: [String] = [String]()
    var workoutIntensity: [String] = [String]()
    var classMusicType: [String] = [String]()
    var dateOfClass: [String] = [String]()
    var locationOfClass: [String] = [String]()
    var classStudents: [Int: String] = [Int: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                        self.classStudents[self.objectId.count] =  object.objectForKey("classStudents") as? String
                        
                        println(self.workoutClassName.count)
                        
                        self.tableView.reloadData()
                        
                    }
                    
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

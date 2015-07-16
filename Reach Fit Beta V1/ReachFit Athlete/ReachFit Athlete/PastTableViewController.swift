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
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // Class data intializer
    var workoutClassName: [String] = [String]()
    var instructorName: [String] = [String]()
    var workoutIntensity: [String] = [String]()
    var classMusicType: [String] = [String]()
    var dateOfClass: [NSDate] = [NSDate]()
    var locationOfClass: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var subscribedClasses: [String] = currentUser!.objectForKey("subscribedClasses") as! [String]
        
        workoutClassName = []
        instructorName = []
        workoutIntensity = []
        classMusicType = []
        dateOfClass = []
        locationOfClass = []
        
        for object in subscribedClasses {
            
            var query = PFQuery(className: "WorkoutClasses")
            query.getObjectInBackgroundWithId(object) {
                (objects: AnyObject?, error: NSError?) -> Void in
                if error == nil && objects != nil {
                    
                    var currentDate: NSDate = NSDate()
                    var date: NSDate = objects?.objectForKey("dateOfClass") as! NSDate
                    
                    if date < currentDate {
                     
                        self.workoutClassName.append(objects!.objectForKey("workoutClassName") as! String)
                        self.instructorName.append(objects!.objectForKey("instructorName") as! String)
                        self.workoutIntensity.append(objects!.objectForKey("workoutIntensity") as! String)
                        self.classMusicType.append(objects!.objectForKey("classMusicType") as! String)
                        self.dateOfClass.append(objects!.objectForKey("dateOfClass") as! NSDate)
                        self.locationOfClass.append(objects!.objectForKey("locationOfClass") as! String)
                        
                    }
                    
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                } else {
                    
                    println(error)
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                }
                
            }
            
        }
        
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        var subscribedClasses: [String] = currentUser!.objectForKey("subscribedClasses") as! [String]
        
        workoutClassName = []
        instructorName = []
        workoutIntensity = []
        classMusicType = []
        dateOfClass = []
        locationOfClass = []
        
        for object in subscribedClasses {
            
            var query = PFQuery(className: "WorkoutClasses")
            query.getObjectInBackgroundWithId(object) {
                (objects: AnyObject?, error: NSError?) -> Void in
                if error == nil && objects != nil {
                    
                    self.workoutClassName.append(objects!.objectForKey("workoutClassName") as! String)
                    self.instructorName.append(objects!.objectForKey("instructorName") as! String)
                    self.workoutIntensity.append(objects!.objectForKey("workoutIntensity") as! String)
                    self.classMusicType.append(objects!.objectForKey("classMusicType") as! String)
                    self.dateOfClass.append(objects!.objectForKey("dateOfClass") as! NSDate)
                    self.locationOfClass.append(objects!.objectForKey("locationOfClass") as! String)
                    
                    self.tableView.reloadData()
                    
                } else {
                    
                    println(error)
                    
                }
                
            }
            
        }
        
        refreshControl.endRefreshing()
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.workoutClassName.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("pastTableViewCellBox") as? PastTableViewCell
        
        if self.workoutClassName.count > 0 {
            
            cell!.pastClassInstructorLabel.text = "\(workoutClassName[indexPath.row]), \(instructorName[indexPath.row])"
            cell!.pastDateCityLabel.text = "\(dateOfClass[indexPath.row]), \(locationOfClass[indexPath.row])"
            cell!.pastIntensityLabel.text = "\(workoutIntensity[indexPath.row])"
            
        }
        
        return cell!
        
    }
    
}


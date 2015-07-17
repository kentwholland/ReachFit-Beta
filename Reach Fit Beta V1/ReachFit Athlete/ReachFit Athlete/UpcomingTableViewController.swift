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
    
    var indexPathOfClickedRow: Int = Int()
    var indexOfObjectToRemove: Int = Int()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // Class data intializer
    var workoutClassName: [String] = [String]()
    var instructorName: [String] = [String]()
    var workoutIntensity: [String] = [String]()
    var classMusicType: [String] = [String]()
    var dateOfClass: [NSDate] = [NSDate]()
    var locationOfClass: [String] = [String]()
    var dateOfClassString: [String] = [String]()
    
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
        
        var subscribedClasses: [String] = currentUser!.objectForKey("subscribedClasses") as! [String]
        println(subscribedClasses)
        
        workoutClassName = []
        instructorName = []
        workoutIntensity = []
        classMusicType = []
        dateOfClass = []
        locationOfClass = []
        
        for object in subscribedClasses {
            
            var currentDate: NSDate = NSDate()
            
            var query = PFQuery(className: "WorkoutClasses")
            query.getObjectInBackgroundWithId(object) {
                (objects: AnyObject?, error: NSError?) -> Void in
                if error == nil && objects != nil {
                    
                    var objectsss: AnyObject? = objects
                    println(objectsss)
                    
                    self.dateOfClass.append(objects!.objectForKey("dateOfClass") as! NSDate)
                    self.workoutClassName.append(objects!.objectForKey("workoutClassName") as! String)
                    self.instructorName.append(objects!.objectForKey("instructorName") as! String)
                    self.workoutIntensity.append(objects!.objectForKey("workoutIntensity") as! String)
                    self.classMusicType.append(objects!.objectForKey("classMusicType") as! String)
                    self.locationOfClass.append(objects!.objectForKey("locationOfClass") as! String)
                    
                    for objects in self.dateOfClass {
                        
                        if objects < currentDate {
                            
                            self.indexOfObjectToRemove = find(self.dateOfClass, objects)!
                            println(self.indexOfObjectToRemove)
                            
                            self.dateOfClass.removeAtIndex(self.indexOfObjectToRemove)
                            self.workoutClassName.removeAtIndex(self.indexOfObjectToRemove)
                            self.instructorName.removeAtIndex(self.indexOfObjectToRemove)
                            self.workoutIntensity.removeAtIndex(self.indexOfObjectToRemove)
                            self.classMusicType.removeAtIndex(self.indexOfObjectToRemove)
                            self.locationOfClass.removeAtIndex(self.indexOfObjectToRemove)
                            
                        }
                        
                    }
                    
                    for objects in self.dateOfClass {
                        
                        var dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
                        var dateNSDate: String = dateFormatter.stringFromDate(objects)
                        var stringTest: String = dateNSDate
                        self.dateOfClassString.append(stringTest)
                        
                    }

                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                } else {
                    
                    println(error)
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                }
                
                println("hello")
                self.tableView.reloadData()
                
            }
            
        }
        
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        var subscribedClasses: [String] = currentUser!.objectForKey("subscribedClasses") as! [String]
        println(subscribedClasses)
        
        workoutClassName = []
        instructorName = []
        workoutIntensity = []
        classMusicType = []
        dateOfClass = []
        locationOfClass = []
        
        for object in subscribedClasses {
            
            var currentDate: NSDate = NSDate()
            
            var query = PFQuery(className: "WorkoutClasses")
            query.getObjectInBackgroundWithId(object) {
                (objects: AnyObject?, error: NSError?) -> Void in
                if error == nil && objects != nil {
                    
                    self.dateOfClass.append(objects!.objectForKey("dateOfClass") as! NSDate)
                    self.workoutClassName.append(objects!.objectForKey("workoutClassName") as! String)
                    self.instructorName.append(objects!.objectForKey("instructorName") as! String)
                    self.workoutIntensity.append(objects!.objectForKey("workoutIntensity") as! String)
                    self.classMusicType.append(objects!.objectForKey("classMusicType") as! String)
                    self.locationOfClass.append(objects!.objectForKey("locationOfClass") as! String)
                    
                    for objects in self.dateOfClass {
                        
                        if objects < currentDate {
                            
                            self.indexOfObjectToRemove = find(self.dateOfClass, objects)!
                            println(self.indexOfObjectToRemove)
                            
                            self.dateOfClass.removeAtIndex(self.indexOfObjectToRemove)
                            self.workoutClassName.removeAtIndex(self.indexOfObjectToRemove)
                            self.instructorName.removeAtIndex(self.indexOfObjectToRemove)
                            self.workoutIntensity.removeAtIndex(self.indexOfObjectToRemove)
                            self.classMusicType.removeAtIndex(self.indexOfObjectToRemove)
                            self.locationOfClass.removeAtIndex(self.indexOfObjectToRemove)
                            
                        }
                        
                    }
                    
                    for objects in self.dateOfClass {
                        
                        var dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
                        var dateNSDate: String = dateFormatter.stringFromDate(objects)
                        var stringTest: String = dateNSDate
                        self.dateOfClassString.append(stringTest)
                        
                    }
                    
                    self.tableView.reloadData()
                    
                } else {
                    
                    println(error)
                    
                }
                
                println("hello")
                self.tableView.reloadData()
                
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
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("upcomingTableViewCellBox") as? UpcomingTableViewCell
        
        if self.workoutClassName.count > 0 {
            
            cell!.upcomingClassInstructorLabel.text = "\(workoutClassName[indexPath.row]), \(instructorName[indexPath.row])"
            cell!.upcomingDateCityLabel.text = "\(dateOfClassString[indexPath.row]), \(locationOfClass[indexPath.row])"
            cell!.upcomingIntensityLabel.text = "\(workoutIntensity[indexPath.row])"
            
        }
        
        return cell!
        
    }
    
}

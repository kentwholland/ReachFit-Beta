//
//  SearchTableTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class SearchTableViewController: UITableViewController, UISearchDisplayDelegate, UISearchBarDelegate {
    
    var indexPathOfClickedRow: Int = Int()

    var indexOfDateToRemove: Int = Int()
    
    var classesIds: [String] = [String]()
    
    // Class data intializer
    var workoutClassName: [String] = [String]()
    var instructorName: [String] = [String]()
    var workoutIntensity: [String] = [String]()
    var classMusicType: [String] = [String]()
    var dateOfClass: [NSDate] = [NSDate]()
    var locationOfClass: [String] = [String]()
    
    var filteredWorkoutClassName: [String] = [String]()
    var filteredInstructorName: [String] = [String]()
    var filteredWorkoutIntensity: [String] = [String]()
    var filteredDateOfClass: [NSDate] = [NSDate]()
    var filteredLocationOfClass: [String] = [String]()
    
    func filterTableViewForEnterText(searchText: String)
    {
        self.filteredWorkoutClassName = self.workoutClassName.filter({( strCountry : String) -> Bool in
            var stringForSearch = strCountry.rangeOfString(searchText)
            return (stringForSearch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        filterTableViewForEnterText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool
    {
        let textScope = searchDisplayController?.searchBar.scopeButtonTitles as! [String]
        filterTableViewForEnterText(self.searchDisplayController!.searchBar.text!)
        
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentDate: NSDate = NSDate()
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        var querys = PFQuery(className: "WorkoutClasses")
        
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
                            self.dateOfClass.append(object.objectForKey("dateOfClass") as! NSDate)
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
                        self.dateOfClass.append(object.objectForKey("dateOfClass") as! NSDate)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "GoToSearchDetailViewController" {
            
            println(instructorName[indexPathOfClickedRow])
            
            var goingToViewController = segue.destinationViewController as! SearchDetailViewController
            goingToViewController.viewControllerTitle = workoutClassName[indexPathOfClickedRow]
            goingToViewController.classInstructor = instructorName[indexPathOfClickedRow]
            goingToViewController.classIntensity = workoutIntensity[indexPathOfClickedRow]
            goingToViewController.classMusicType = classMusicType[indexPathOfClickedRow]
            goingToViewController.classDate = "\(dateOfClass[indexPathOfClickedRow])"
            goingToViewController.classCity = locationOfClass[indexPathOfClickedRow]
            goingToViewController.classIds = classesIds[indexPathOfClickedRow]
            
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

        if tableView == self.searchDisplayController!.searchResultsTableView
        {
            return filteredWorkoutClassName.count
            
        } else {
            
            return workoutClassName.count
            
        }
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SearchTableViewCellBox") as? SearchTableViewCell

        if tableView == searchDisplayController?.searchResultsTableView {
            
            cell?.searchClassInstructorLabel.text = "\(filteredWorkoutClassName[indexPath.row])"
            
            return cell!
            
        } else {
            
            cell?.searchClassInstructorLabel.text = "\(workoutClassName[indexPath.row]), \(instructorName[indexPath.row])"
            cell?.searchDateCityLabel.text = "\(dateOfClass[indexPath.row]), \(locationOfClass[indexPath.row])"
            cell?.searchIntensityLabel.text = "\(workoutIntensity[indexPath.row])"
            
            return cell!
            
        }
        
    }

}

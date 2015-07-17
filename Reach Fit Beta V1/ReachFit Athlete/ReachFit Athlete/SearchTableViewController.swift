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

    var indexOfObjectToRemove: Int = Int()
    
    var classesIds: [String] = [String]()
    
    // Class data intializer
    var workoutClassName: [String] = [String]()
    var instructorName: [String] = [String]()
    var workoutIntensity: [String] = [String]()
    var classMusicType: [String] = [String]()
    var dateOfClass: [NSDate] = [NSDate]()
    var locationOfClass: [String] = [String]()
    var dateOfClassString: [String] = [String]()
    
    var filteredWorkoutClassName: [String] = [String]()
    var filteredInstructorName: [String] = [String]()
    var filteredWorkoutIntensity: [String] = [String]()
    var filteredDateOfClassString: [String] = [String]()
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
                        
                        for objects in self.dateOfClass {
                            
                            if objects < currentDate {
                                
                                self.indexOfObjectToRemove = find(self.dateOfClass, objects)!
                                
                                self.workoutClassName.removeAtIndex(self.indexOfObjectToRemove)
                                self.instructorName.removeAtIndex(self.indexOfObjectToRemove)
                                self.workoutIntensity.removeAtIndex(self.indexOfObjectToRemove)
                                self.classMusicType.removeAtIndex(self.indexOfObjectToRemove)
                                self.dateOfClass.removeAtIndex(self.indexOfObjectToRemove)
                                self.locationOfClass.removeAtIndex(self.indexOfObjectToRemove)
                                self.classesIds.removeAtIndex(self.indexOfObjectToRemove)
                                
                            }
                            
                        }
                        
                        for objects in self.dateOfClass {
                            
                            var dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm a"
                            var dateNSDate: String = dateFormatter.stringFromDate(objects)
                            var stringTest: String = dateNSDate
                            self.dateOfClassString.append(stringTest)
                            
                        }
                    
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
                    self.dateOfClassString = []
                    
                    for object in objects {
                        
                        self.workoutClassName.append(object.objectForKey("workoutClassName") as! String)
                        self.instructorName.append(object.objectForKey("instructorName") as! String)
                        self.workoutIntensity.append(object.objectForKey("workoutIntensity") as! String)
                        self.classMusicType.append(object.objectForKey("classMusicType") as! String)
                        self.dateOfClass.append(object.objectForKey("dateOfClass") as! NSDate)
                        self.locationOfClass.append(object.objectForKey("locationOfClass") as! String)
                        self.classesIds.append(object.objectId! as String)
                        
                        var currentDate: NSDate = NSDate()
                        
                        for objects in self.dateOfClass {
                            
                            if objects < currentDate {
                                
                                self.indexOfObjectToRemove = find(self.dateOfClass, objects)!
                                
                                self.workoutClassName.removeAtIndex(self.indexOfObjectToRemove)
                                self.instructorName.removeAtIndex(self.indexOfObjectToRemove)
                                self.workoutIntensity.removeAtIndex(self.indexOfObjectToRemove)
                                self.classMusicType.removeAtIndex(self.indexOfObjectToRemove)
                                self.dateOfClass.removeAtIndex(self.indexOfObjectToRemove)
                                self.locationOfClass.removeAtIndex(self.indexOfObjectToRemove)
                                self.classesIds.removeAtIndex(self.indexOfObjectToRemove)
                                
                            }
                            
                        }
                        
                        for objects in self.dateOfClass {
                            
                            var dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm a"
                            var dateNSDate: String = dateFormatter.stringFromDate(objects)
                            var stringTest: String = dateNSDate
                            self.dateOfClassString.append(stringTest)
                            
                        }
                        
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
            goingToViewController.classDate = "\(dateOfClassString[indexPathOfClickedRow])"
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
            cell?.searchDateCityLabel.text = "\(dateOfClassString[indexPath.row]), \(locationOfClass[indexPath.row])"
            cell?.searchIntensityLabel.text = "\(workoutIntensity[indexPath.row])"
            
            return cell!
            
        }
        
    }

}

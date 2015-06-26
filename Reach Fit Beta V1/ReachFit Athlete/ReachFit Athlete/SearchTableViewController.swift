//
//  SearchTableTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var query = PFQuery(className: "WorkoutClasses")
    
    // Class data intializer
    var objectId: [String] = [String]()
    var workoutClassName: [String] = [String]()
    var instructorName: [String] = [String]()
    var workoutIntensity: [String] = [String]()
    var classMusicType: [String] = [String]()
    var dateOfClass: [String] = [String]()
    var locationOfClass: [String] = [String]()
    var classStudents: [Int: String] = [Int: String]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "CustomSearchCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCellBox")
        
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        
                        self.objectId.append(object.objectForKey("objectId") as! String)
                        self.workoutClassName.append(object.objectForKey("workoutClassName") as! String)
                        self.instructorName.append(object.objectForKey("instructorName") as! String)
                        self.workoutIntensity.append(object.objectForKey("workoutIntensity") as! String)
                        self.classMusicType.append(object.objectForKey("classMusicType") as! String)
                        self.dateOfClass.append(object.objectForKey("dateOfClass") as! String)
                        self.locationOfClass.append(object.objectForKey("locationOfClass") as! String)
                        self.classStudents[self.objectId.count] =  object.objectForKey("classStudents") as? String
                        
                    
                    }
                    
                }
            } else {
                println("\(error?.userInfo)")
            }
        }
        
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return objectId.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        searchClassInstructorLabel
//        searchDateCityLabel
//        searchIntensityLabel
        
        var  cell:SearchTableViewCell? = tableView.dequeueReusableCellWithIdentifier("SearchTableViewCellBox") as? SearchTableViewCell
        
        cell?.searchClassInstructorLabel.text = ""
        cell?.searchDateCityLabel.text = ""
        cell?.searchIntensityLabel.text = ""
        
        if cell == nil {
            let nib:Array = NSBundle.mainBundle().loadNibNamed("CustomSearchCell", owner: self, options: nil)
            cell = nib[0] as? SearchTableViewCell
        }
        
        
        
        return cell!
    }

}

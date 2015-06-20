//
//  FindViewController.swift
//  ReachFit Beta
//
//  Created by Stefan DeClerck on 6/9/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class AvailableNearbyViewController: UITableViewController, UITableViewDataSource {

    var testOfNumberOfClasses: [String] = [String]()
    var listOfClassFullNames: [String] = [String]()
    var listOfClassTopics: [String] = [String]()
    var listOfInstructors: [String] = [String]()
    var listOfClassDates: [String] = [String]()
    var listOfClassDescriptions: [String] = [String]()
    var totalNumberOfRows: Int = 0
    var query = PFQuery(className:"Classes")
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfClassFullNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = listOfClassFullNames[indexPath.row]
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow()
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!)
        classFullNameLabelVCText = currentCell?.textLabel!.text as String!
        classTopicLabelVCText = self.listOfClassTopics[indexPath!.row]
        instructorLabelVCText = self.listOfInstructors[indexPath!.row]
        classDateLabelVCText = self.listOfClassDates[indexPath!.row]
        classDescriptionLabelVCTest = self.listOfClassDescriptions[indexPath!.row]

    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        self.testOfNumberOfClasses = [String]()
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    
                    self.listOfClassFullNames = []
                    self.listOfClassTopics = []
                    self.listOfInstructors = []
                    self.listOfClassDates = []
                    self.listOfClassDescriptions = []
                    
                    for object in objects {
                        
                            self.listOfClassFullNames.append(object.objectForKey("classFullName") as! String)
                            self.listOfClassTopics.append(object.objectForKey("classTopic") as! String)
                            self.listOfInstructors.append(object.objectForKey("instructor") as! String)
                            self.listOfClassDates.append(object.objectForKey("classDate") as! String)
                            self.listOfClassDescriptions.append(object.objectForKey("classDescription") as! String)
                            
                            self.tableView.reloadData()
                        
                    }
                }
            }
        }
        
        refreshControl.endRefreshing()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        self.listOfClassFullNames.append(object.objectForKey("classFullName") as! String)
                        self.listOfClassTopics.append(object.objectForKey("classTopic") as! String)
                        self.listOfInstructors.append(object.objectForKey("instructor") as! String)
                        self.listOfClassDates.append(object.objectForKey("classDate") as! String)
                        self.listOfClassDescriptions.append(object.objectForKey("classDescription") as! String)
                    }
                }
            } else {
                println("\(error?.userInfo)")
            }
            self.tableView.reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//         Dispose of any resources that can be recreated.
    }

}

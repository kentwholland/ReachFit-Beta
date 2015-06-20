//
//  YourClassesViewController.swift
//  ReachFit Beta
//
//  Created by Stefan DeClerck on 6/9/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class YourClassesViewController: UITableViewController, UITableViewDataSource {
    
    var listOfSubscribedClass: [String] = [String]()
    var listOfSubscribedTopic: [String] = [String]()
    var listOfSubscribedInstructor: [String] = [String]()
    var listOfSubscribedDate: [String] = [String]()
    var listOfSubscribedDescription: [String] = [String]()
    
    var query = PFQuery(className:"currentClassSelection")
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfSubscribedClass.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = listOfSubscribedClass[indexPath.row]
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow()
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!)
        classFullNameLabelSubscribed = currentCell?.textLabel!.text as String!
        classTopicLabelSubscribed = self.listOfSubscribedTopic[indexPath!.row]
        instructorLabelSubscribed = self.listOfSubscribedInstructor[indexPath!.row]
        classDateLabelSubscribed = self.listOfSubscribedDate[indexPath!.row]
        classDescriptionLabelSubscribed = self.listOfSubscribedDescription[indexPath!.row]
        
    }
    
    @IBAction func refreshStarted(sender: AnyObject) {
        println("run")
        
        
        println("refresh started")
        
        var currentUser = PFUser.currentUser()
        var currentUsername = currentUser?.username
        
        query.whereKey("CurrentUsername", equalTo:currentUsername!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count)")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    
                    self.listOfSubscribedClass = []
                    self.listOfSubscribedInstructor = []
                    self.listOfSubscribedTopic = []
                    self.listOfSubscribedDescription = []
                    self.listOfSubscribedDate = []
                    
                    for object in objects {
                        
                        self.listOfSubscribedClass.append(object.objectForKey("classFullName") as! String)
                        self.listOfSubscribedInstructor.append(object.objectForKey("instructor") as! String)
                        self.listOfSubscribedTopic.append(object.objectForKey("classTopic") as! String)
                        self.listOfSubscribedDescription.append(object.objectForKey("classDescription") as! String)
                        self.listOfSubscribedDate.append(object.objectForKey("classDate") as! String)
                        
                    }
                }
            }
            self.tableView.reloadData()
        }
        
        refreshControl?.endRefreshing()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = PFUser.currentUser()
        var currentUsername = currentUser?.username
        
        query.whereKey("CurrentUsername", equalTo:currentUsername!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count)")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        self.listOfSubscribedClass.append(object.objectForKey("classFullName") as! String)
                        self.listOfSubscribedInstructor.append(object.objectForKey("instructor") as! String)
                        self.listOfSubscribedTopic.append(object.objectForKey("classTopic") as! String)
                        self.listOfSubscribedDescription.append(object.objectForKey("classDescription") as! String)
                        self.listOfSubscribedDate.append(object.objectForKey("classDate") as! String)
                    }
                }
            }
            self.tableView.reloadData()
        }
        
//         Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//         Dispose of any resources that can be recreated.
    }

}

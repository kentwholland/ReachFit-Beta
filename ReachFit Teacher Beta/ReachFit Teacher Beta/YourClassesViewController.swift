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
    
    var listOfYourClassNames: [String] = [String]()
    var listOfYouClassTopics: [String] = [String]()
    var listOfYourClassDates: [String] = [String]()
    var listOfYourClassDescriptions: [String] = [String]()
    
    var query = PFQuery(className:"Classes")
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfYourClassNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = listOfYourClassNames[indexPath.row]
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow()
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!)
        classFullNameLabelSubscribed = currentCell?.textLabel!.text as String!
        classTopicLabelSubscribed = self.listOfYouClassTopics[indexPath!.row]
        classDateLabelSubscribed = self.listOfYourClassDates[indexPath!.row]
        classDescriptionLabelSubscribed = self.listOfYourClassDescriptions[indexPath!.row]
        
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
                    
                    self.listOfYourClassNames = []
                    self.listOfYouClassTopics = []
                    self.listOfYourClassDescriptions = []
                    self.listOfYourClassDates = []
                    
                    for object in objects {
                        
                        self.listOfYourClassNames.append(object.objectForKey("classFullName") as! String)
                        self.listOfYouClassTopics.append(object.objectForKey("classTopic") as! String)
                        self.listOfYourClassDescriptions.append(object.objectForKey("classDescription") as! String)
                        self.listOfYourClassDates.append(object.objectForKey("classDate") as! String)
                        
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
                        self.listOfYourClassNames.append(object.objectForKey("classFullName") as! String)
                        self.listOfYouClassTopics.append(object.objectForKey("classTopic") as! String)
                        self.listOfYourClassDescriptions.append(object.objectForKey("classDescription") as! String)
                        self.listOfYourClassDates.append(object.objectForKey("classDate") as! String)
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

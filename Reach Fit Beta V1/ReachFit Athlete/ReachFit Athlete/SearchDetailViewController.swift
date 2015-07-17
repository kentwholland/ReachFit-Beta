//
//  SearchDetailTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/30/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class SearchDetailViewController: UIViewController {
    
    var classesIds: [String] = [String]()
    
    @IBOutlet weak var joinLeaveButton: UIButton!
    
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var musicTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var viewControllerTitle: String = ""
    var classInstructor: String = ""
    var classIntensity: String = ""
    var classMusicType: String = ""
    var classDate: String = ""
    var classCity: String = ""
    var classIds: String = ""
    
    @IBAction func addOrRemoveFromClasses(sender: AnyObject) {
        
        if self.joinLeaveButton.titleLabel?.text == "Join" {
            
            println("user \(PFUser.currentUser()!.objectId!) joined :)")
            
            PFUser.currentUser()?.addObject(self.classIds, forKey: "subscribedClasses")
            PFUser.currentUser()?.save()
            var classesQuery = PFQuery(className: "WorkoutClasses")
            var classesObject = classesQuery.getObjectWithId(self.classIds)
            classesObject!.addObject(PFUser.currentUser()!.objectId!, forKey: "classStudents")
            classesObject!.save()
            
            runObjectFind()
            
            
        } else if self.joinLeaveButton.titleLabel?.text == "Leave" {
            
            PFUser.currentUser()?.removeObject(self.classIds, forKey: "subscribedClasses")
            PFUser.currentUser()?.save()
            var classesQuery = PFQuery(className: "WorkoutClasses")
            var classesObject = classesQuery.getObjectWithId(self.classIds)
            classesObject!.removeObject(PFUser.currentUser()!.objectId!, forKey: "classStudents")
            classesObject!.save()
            
            println("user \(PFUser.currentUser()!.objectId!) left :'(")
            
            runObjectFind()
            
        }
        
    }
    
    func constantCheck() {
        
        if contains(classesIds, PFUser.currentUser()!.objectId!) {
            
            joinLeaveButton.setTitle("Leave", forState: UIControlState.Normal)
            
        } else {
            
            joinLeaveButton.setTitle("Join", forState: UIControlState.Normal)
            
        }
        
    }
    
    func runObjectFind() {
        
        var query = PFQuery(className:"WorkoutClasses")
        query.getObjectInBackgroundWithId("\(classIds)") {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                
                println("error")
                
            } else if object == nil {
                
                println("nothing in here")
                
            } else if object != nil {
                
                var usersInClass: AnyObject? = object?.objectForKey("classStudents") as! [String]
                self.classesIds = usersInClass as! [String]
                println(self.classesIds)
                
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runObjectFind()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("constantCheck"), userInfo: nil, repeats: true)
        
        instructorLabel.text = classInstructor
        intensityLabel.text = classIntensity
        musicTypeLabel.text = classMusicType
        dateLabel.text = classDate
        cityLabel.text = classCity
        self.navigationItem.title = viewControllerTitle
        
    }

}

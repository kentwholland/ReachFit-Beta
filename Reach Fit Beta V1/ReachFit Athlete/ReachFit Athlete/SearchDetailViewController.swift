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
        
        if self.joinLeaveButton.titleLabel == "Join" {
            
            println("user \(currentUser!.objectId!) joined :)")
            
            currentUser?.addObject(self.classIds, forKey: "subscribedClasses")
            currentUser?.save()
            var classesQuery = PFQuery(className: "WorkoutClasses")
            var classesObject = classesQuery.getObjectWithId(self.classIds)
            classesObject!.addObject(currentUser!.objectId!, forKey: "classStudents")
            classesObject!.save()
            
            
        } else if self.joinLeaveButton.titleLabel == "Leave" {
            
            currentUser?.removeObject(self.classIds, forKey: "subscribedClasses")
            currentUser?.save()
            var classesQuery = PFQuery(className: "WorkoutClasses")
            var classesObject = classesQuery.getObjectWithId(self.classIds)
            classesObject!.removeObject(currentUser!.objectId!, forKey: "classStudents")
            classesObject!.save()
            
            println("user \(currentUser!.objectId!) left :'(")
            
        }
        
    }
    
    func constantCheck() {
        
        if contains(classesIds, currentUser!.objectId!) {
            
            joinLeaveButton.setTitle("Leave", forState: .Normal)
            
        } else {
            
            joinLeaveButton.setTitle("Join", forState: .Normal)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFQuery(className:"WorkoutClasses")
        query.getObjectInBackgroundWithId("\(classIds)") {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil && object != nil {
                
                var usersInClass: AnyObject? = object?.objectForKey("classStudents") as! [String]
                self.classesIds = usersInClass as! [String]
                println(self.classesIds)
                
            } else {
                println(error)
            }
        }
        
        self.joinLeaveButton.setTitle("", forState: .Normal)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("constantCheck"), userInfo: nil, repeats: true)
        
        instructorLabel.text = classInstructor
        intensityLabel.text = classIntensity
        musicTypeLabel.text = classMusicType
        dateLabel.text = classDate
        cityLabel.text = classCity
        self.navigationItem.title = viewControllerTitle
        
    }

}

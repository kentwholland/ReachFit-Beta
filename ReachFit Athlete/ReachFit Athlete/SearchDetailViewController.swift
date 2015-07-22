//
//  SearchDetailTableViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/30/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class SearchDetailViewController: UIViewController {
    
    var stringDate: String = String()
    var currentObject : PFObject?
    
    var usersInClass: [String] = [String]()
    var currentObjectID: String = String()
    
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var musicTypeLabel: UILabel!
    @IBOutlet weak var instensityLabel: UILabel!
    
    @IBOutlet weak var joinLeaveButton: UIButton!
    
    func checkUserState() {
        
        if contains(usersInClass, PFUser.currentUser()!.objectId!) {
            
            joinLeaveButton.setTitle("Leave", forState: .Normal)
            
        } else {
            
            joinLeaveButton.setTitle("Join", forState: .Normal)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let object = currentObject {
            
            if let dateObject = object["dateOfClass"] as? NSDate {
                
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy HH:mm a"
                var dateNSDate: String = dateFormatter.stringFromDate(dateObject)
                stringDate = dateNSDate
                
            }
            
            currentObjectID = object.objectId! as String!
            usersInClass = object["classStudents"] as! [String]
            self.navigationItem.title = object["workoutClassName"] as? String
            instructorLabel.text = object["instructorName"] as? String
            dateLabel.text = stringDate
            cityLabel.text = object["locationOfClass"] as? String
            musicTypeLabel.text = object["classMusicType"] as? String
            instensityLabel.text = object["workoutIntensity"] as? String
            
        }
        
        checkUserState()

        
    }
    
    @IBAction func joinLeaveClass(sender: AnyObject) {
        
        if joinLeaveButton.titleLabel?.text == "Join" {
            
            println("join")
            KSToastView.ks_showToast("Class Joined", duration: 1.5, completion: { () -> Void in
                
            })
            PFUser.currentUser()?.addObject(self.currentObjectID, forKey: "subscribedClasses")
            PFUser.currentUser()?.save()
            var classesQuery = PFQuery(className: "WorkoutClasses")
            var classesObject = classesQuery.getObjectWithId(self.currentObjectID)
            classesObject!.addObject(PFUser.currentUser()!.objectId!, forKey: "classStudents")
            classesObject!.save()
            
            navigationController?.popViewControllerAnimated(true)
            
        } else if joinLeaveButton.titleLabel?.text == "Leave" {
            
            println("Leave")
            KSToastView.ks_showToast("Class Left", duration: 1.5, completion: { () -> Void in
                
            })
            PFUser.currentUser()?.removeObject(self.currentObjectID, forKey: "subscribedClasses")
            PFUser.currentUser()?.save()
            var classesQuery = PFQuery(className: "WorkoutClasses")
            var classesObject = classesQuery.getObjectWithId(self.currentObjectID)
            classesObject!.removeObject(PFUser.currentUser()!.objectId!, forKey: "classStudents")
            classesObject!.save()
            
            navigationController?.popViewControllerAnimated(true)
            
        } else {
            
            println("There is no option at this point")
            
        }
        
    }

}

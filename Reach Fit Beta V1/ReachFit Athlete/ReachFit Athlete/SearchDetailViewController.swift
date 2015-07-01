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
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            currentUser?.addObject(self.classIds, forKey: "subscribedClasses")
            currentUser?.save()
            var classesQuery = PFQuery(className: "WorkoutClasses")
            var classesObject = classesQuery.getObjectWithId(self.classIds)
            classesObject!.addObject(currentUser!.objectId!, forKey: "classStudents")
            classesObject!.save()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("\(viewControllerTitle)")
        
        instructorLabel.text = classInstructor
        intensityLabel.text = classIntensity
        musicTypeLabel.text = classMusicType
        dateLabel.text = classDate
        cityLabel.text = classCity
        self.navigationItem.title = viewControllerTitle
        
    }

}

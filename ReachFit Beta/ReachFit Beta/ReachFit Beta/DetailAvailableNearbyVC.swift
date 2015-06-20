//
//  detailAvailableNearbyVC.swift
//  ReachFit Beta
//
//  Created by Stefan DeClerck on 6/10/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Foundation

var classFullNameLabelVCText: String = "test"
var classTopicLabelVCText: String = "test"
var instructorLabelVCText: String = "test"
var classDateLabelVCText: String = "test"
var classDescriptionLabelVCTest: String = "test"

var query = PFQuery(className: "Classes")

class DetailAvailableNearbyVC: UIViewController {

    @IBAction func addToClassesToTake(sender: AnyObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            var currentUser = PFUser.currentUser()
            var usernamePerson = currentUser?.username;
            
            var addedClassToTake = PFObject(className:"currentClassSelection")
            addedClassToTake["classFullName"] = classFullNameLabelVCText
            addedClassToTake["instructor"] = instructorLabelVCText
            addedClassToTake["classTopic"] = classTopicLabelVCText
            addedClassToTake["classDescription"] = classDescriptionLabelVCTest
            addedClassToTake["classDate"] = classDateLabelVCText
            addedClassToTake["CurrentUsername"] = usernamePerson
            addedClassToTake.save()
            
        })
        
    }
    
    @IBOutlet weak var classFullNameLabel: UILabel!
    @IBOutlet weak var classTopicLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var classDateLabel: UILabel!
    @IBOutlet weak var classDescriptionLabel: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        updateLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabels()
    }
    
    func updateLabels() {
        classFullNameLabel.text = classFullNameLabelVCText
        classTopicLabel.text = classTopicLabelVCText
        instructorLabel.text = instructorLabelVCText
        classDateLabel.text = classDateLabelVCText
        classDescriptionLabel.text = classDescriptionLabelVCTest
    }

}

//
//  PastDetailViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 7/22/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class PastDetailViewController: UIViewController {

    var stringDate: String = String()
    var currentObject : PFObject?
    
    var usersInClass: [String] = [String]()
    var currentObjectID: String = String()
    
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var musicTypeLabel: UILabel!
    @IBOutlet weak var instensityLabel: UILabel!
    
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
        
    }
    
}

//
//  AddViewController.swift
//  ReachFit Teacher Beta
//
//  Created by Stefan DeClerck on 6/16/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class AddViewController: UIViewController {

    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var workoutTypeTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBAction func done(sender: AnyObject) {
        var currentUsername: PFUser = PFUser.currentUser()!
        var newClass = PFObject(className: "Classes")
        newClass["instructor"] = currentUsername.username
        newClass["classFullName"] = classNameTextField.text
        newClass["classTopic"] = workoutTypeTextField.text
        newClass["classDescription"] = descriptionTextField.text
        newClass["classDate"] = dateTextField.text
        
        if classNameTextField.text == "" || workoutTypeTextField.text == "" || descriptionTextField.text == "" || dateTextField == "" {
            var alert = UIAlertController(title: "Error", message: "Make sure to fill in all fields", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            newClass.saveInBackgroundWithBlock { (success, error) -> Void in
                if error != nil {
                    var alert = UIAlertController(title: "Error", message: "There is an error with the given information", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {

                    self.dismissViewControllerAnimated(true, completion: nil)
            }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        var frameRect: CGRect = descriptionTextField.frame;
        frameRect.size.height = 53;
        descriptionTextField.frame = frameRect;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

//
//  YourPageViewController.swift
//  ReachFit Beta
//
//  Created by Stefan DeClerck on 6/9/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class YourPageViewController: UIViewController {
    
    var window: UIWindow?
    
    @IBOutlet weak var currentAgeTextField: UILabel!
    @IBOutlet weak var currentEmailTextField: UILabel!
    @IBOutlet weak var currentUsernameTextField: UILabel!
    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        if PFUser.currentUser() == nil {
            println("Log Out Complete")
            CurrentUserInfo.currentUserAge = ""
            CurrentUserInfo.currentUserEmail = ""
            CurrentUserInfo.currentUserUsername = ""
            self.performSegueWithIdentifier("finishLogout", sender: self)
        } else  {
            let alertController = UIAlertController(title: "Error", message:
                "Log Out Attempt Invalid", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            println("Log Out Failed")
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUsernameTextField.text = CurrentUserInfo.currentUserUsername
        currentEmailTextField.text = CurrentUserInfo.currentUserEmail
        currentAgeTextField.text = CurrentUserInfo.currentUserAge
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

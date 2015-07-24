//
//  UserSettingsViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/23/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class UserSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        var availableUser = PFUser.currentUser()
        
        if availableUser == nil {
            
            self.performSegueWithIdentifier("userLogout", sender: self)
            println("logout success")
            KSToastView.ks_showToast("Logout Success", duration: 1.5, completion: { () -> Void in
                
            })
            
        } else if availableUser != nil {
            
            println("logout fail")
            KSToastView.ks_showToast("Logout Attempt Fqailed", duration: 1.5, completion: { () -> Void in
                
            })
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

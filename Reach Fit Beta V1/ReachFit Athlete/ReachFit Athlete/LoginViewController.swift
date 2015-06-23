//
//  LoginViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/20/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func Login(sender: AnyObject) {
        println("login clicked")
        
        var currentUser = PFUser.currentUser()
        
        PFUser.logInWithUsernameInBackground(emailTextField.text, password: passwordTextField.text) { (curretUser, error) -> Void in
            if error == nil {
                println("success")
                self.performSegueWithIdentifier("finishLogin", sender: self)
            } else {
                println("Failure")
        
            }
        }
        
    }
    
    func checkInputComplete() {
        if emailTextField.text == "" || passwordTextField.text == "" {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("checkInputComplete"), userInfo: nil, repeats: true)
        
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
}

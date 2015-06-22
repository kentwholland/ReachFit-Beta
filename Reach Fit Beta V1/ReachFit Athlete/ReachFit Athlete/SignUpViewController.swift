//
//  SignUpViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/20/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var DOBTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    @IBAction func signUp(sender: AnyObject) {
        
        let user = PFUser()
        user.password = passwordTextField.text
        user.email = emailTextField.text
        user["isStudent"] = true
        user["firstName"] = firstNameTextField.text
        user["lastName"] = lastNameTextField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error{
                let alertController = UIAlertController(title: "Alert", message:
                    "There is a problem with the given information", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                CurrentUserInfo.currentUserEmail = self.emailTextField.text
                CurrentUserInfo.currentUserFirstName = self.firstNameTextField.text
                CurrentUserInfo.currentUserLastName = self.lastNameTextField.text
                println("success")
                self.performSegueWithIdentifier("finishSignUp", sender:self)
            }
        }
        
    }
    
    func checkInputComplete() {
        if emailTextField.text != "" || passwordTextField.text != "" {
            nextButton.enabled = true
        } else {
            nextButton.enabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("checkInputComplete"), userInfo: nil, repeats: true)
        
        self.firstNameTextField.becomeFirstResponder()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        DOBTextField.delegate = self
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
}

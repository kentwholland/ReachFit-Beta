//
//  SignUpViewController.swift
//  ReachFit Beta
//
//  Created by Stefan DeClerck on 6/8/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUp(sender: AnyObject) {
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        user.email = emailTextField.text
        user.setObject("true", forKey: "isStudent")
        user.setObject(ageTextField.text, forKey: "userAge")

        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error{
                let alertController = UIAlertController(title: "Alert", message:
                    "There is a problem with the given information", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                CurrentUserInfo.currentUserUsername = self.usernameTextField.text
                CurrentUserInfo.currentUserEmail = self.emailTextField.text
                CurrentUserInfo.currentUserAge = self.ageTextField.text
                println("success")
                self.performSegueWithIdentifier("finishSignUp", sender:self)
            }
        }
    }
    
    func checkInputComplete() {
        if usernameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" && ageTextField.text != "" {
            doneButton.enabled = true
        } else {
            doneButton.enabled = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("checkInputComplete"), userInfo: nil, repeats: true)
        
        self.usernameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.usernameTextField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
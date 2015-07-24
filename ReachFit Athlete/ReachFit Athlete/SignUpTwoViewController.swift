//
//  signUpTwoViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/20/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class SignUpTwoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {
    
    var sliderValue: String = String()
    var fitnessGoalTextViewText: String = String()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var instructionLabel1: UILabel!
    @IBOutlet weak var instructionLabel2: UILabel!
    @IBOutlet weak var fitnessGoalTextView: UITextView!
    @IBOutlet weak var fitnessLevelSlider: UISlider!
    @IBOutlet weak var oneLevelLabel: UILabel!
    @IBOutlet weak var fiveLevelLabel: UILabel!
    @IBOutlet weak var instructionLevelLabel: UILabel!
    
    var standardViewHeight: CGFloat = 0

    @IBAction func sliderValueChange(slider: UISlider) {
        
        println(slider.value)
        sliderValue = "\(slider.value)"
        
    }
    
    @IBAction func done(sender: AnyObject) {
        
        var currentUser = PFUser.currentUser()
        var user = PFUser.currentUser()
        
        println(sliderValue)
        fitnessGoalTextViewText = fitnessGoalTextView.text
        println(fitnessGoalTextViewText)
        
        if fitnessGoalTextView.text == "Describe your fitness goal!" || profileImage.image == nil{
            
            KSToastView.ks_showToast("Make sure to complete all input", duration: 2.0, completion: { () -> Void in
                
                
            })
            
        } else {
            
            user?.setObject(fitnessGoalTextViewText, forKey: "fitnessGoal")
            user?.setObject(sliderValue, forKey: "fitnessLevelNumber")
            
            user!.saveInBackgroundWithBlock({ (success, error) -> Void in
                
                if error == nil {
                    
                    self.performSegueWithIdentifier("finishSignUp", sender: self)
                    
                } else {
                    
                    var myError: String = error?.userInfo!["error"] as! String
                    KSToastView.ks_showToast("\(myError)", duration: 2.0, completion: { () -> Void in
                        
                        
                    })
                    
                }
                
            })
            
        }
        
    }
    
    @IBAction func profileImageTapped(sender: AnyObject) {
        
        println("image tapped")
        
        instructionLabel1.hidden = true
        instructionLabel2.hidden = true
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
        
        let user = PFUser.currentUser()
        
        profileImage.image = image
        
        let imageData = UIImagePNGRepresentation(profileImage.image)
        let imageFile = PFFile(name: "image.png", data: imageData)
        
        user?.setObject(imageFile, forKey: "profilePicture")

        user!.saveInBackgroundWithBlock { (success, error) -> Void in
            if error == nil {
                
                println("image upload success")
                
            } else {
             
                var myError: String = error?.userInfo!["error"] as! String
                KSToastView.ks_showToast("\(myError)", duration: 2.0, completion: { () -> Void in
                    
                    
                })
                
            }
        }
        
    }
    
    func keyboardWillShow(notification : NSNotification) {
        
        var keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size
        
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.view.center.y = 150
        })
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        fitnessGoalTextView.resignFirstResponder()
    }
    
    func keyboardWillHide(notification : NSNotification) {
        self.view.center.y = standardViewHeight
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderValue = "3"
        
        let newView = UIView()
        
        standardViewHeight = self.view.center.y
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        fitnessGoalTextView.delegate = self
        
        profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        profileImage.clipsToBounds = true;
        profileImage.userInteractionEnabled = true
        
    }
    
}

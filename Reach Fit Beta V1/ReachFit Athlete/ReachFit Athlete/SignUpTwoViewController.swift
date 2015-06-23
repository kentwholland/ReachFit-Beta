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
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var instructionLabel1: UILabel!
    @IBOutlet weak var instructionLabel2: UILabel!
    @IBOutlet weak var fitnessGoalTextView: UITextView!
    @IBOutlet weak var fitnessLevelSlider: UISlider!
    @IBOutlet weak var oneLevelLabel: UILabel!
    @IBOutlet weak var fiveLevelLabel: UILabel!
    @IBOutlet weak var instructionLevelLabel: UILabel!
    
    var standardViewHeight: CGFloat = 0
    
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
             
                var alert = UIAlertController(title: "Error", message: "Could not set profile picture", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                })))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
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

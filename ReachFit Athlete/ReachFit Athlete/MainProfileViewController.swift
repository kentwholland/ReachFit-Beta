//
//  MainProfileViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/23/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class MainProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var fitnessGoalLabels: UITextView!
    @IBOutlet weak var fitnessLevelNumber: UILabel!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion:nil)
        
        let user = PFUser.currentUser()
        
        profileImageView.image = image
        
        let imageData = UIImagePNGRepresentation(profileImageView.image)
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
    
    @IBAction func profileImageViewTapped(sender: AnyObject) {
        
        var image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fitnessLevelNumber.text = PFUser.currentUser()?.objectForKey("fitnessLevelNumber") as? String
        fitnessGoalLabels.text = PFUser.currentUser()?.objectForKey("fitnessGoal") as? String
        profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        profileImageView.clipsToBounds = true;
        profileImageView.userInteractionEnabled = true
        
        var firstName: String = PFUser.currentUser()?.objectForKey("firstName") as! String
        var lastName: String = PFUser.currentUser()?.objectForKey("lastName") as! String
        
        self.userNameLabel.text = "\(firstName) \(lastName)"
        
        let pictureObject: AnyObject? = PFUser.currentUser()?.objectForKey("profilePicture") as! PFFile
        pictureObject!.getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
            if error == nil {
                let image = UIImage(data: imageData!)
                self.profileImageView.image = image
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

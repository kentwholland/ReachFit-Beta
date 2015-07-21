//
//  CurrentUserInfo.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/20/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import Foundation
import UIKit
import Parse

struct CurrentUserInfo {
    
    static var currentUserId = PFUser.currentUser()!.objectForKey("objectId") as! String
    static var currentUserEmail = PFUser.currentUser()!.objectForKey("email") as! String
    static var currentUserFirstName = PFUser.currentUser()!.objectForKey("firstName") as! String
    static var currentUserLastName = PFUser.currentUser()!.objectForKey("lastName") as! String
    static var currentUserDateOfBirth = PFUser.currentUser()!.objectForKey("dateOfBirth") as! NSDate
    static var currentUserFitnessLevel = PFUser.currentUser()!.objectForKey("fitnessLevelNumber") as! String
    static var currentUserFitnessGoals = PFUser.currentUser()!.objectForKey("fitnessGoal") as! String
    static var currentUserProfilePic: PFFile = PFUser.currentUser()!.objectForKey("profilePicture") as! PFFile
    static var currentUserSubscribedClasses: [String] = PFUser.currentUser()!.objectForKey("subscribedClasses") as! [String]
    
}
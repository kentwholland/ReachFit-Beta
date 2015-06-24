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
    
    static var currentUserEmail = currentUser!.objectForKey("email") as! String
    static var currentUserFirstName = currentUser!.objectForKey("firstName") as! String
    static var currentUserLastName = currentUser!.objectForKey("lastName") as! String
    static var currentUserDateOfBirth = currentUser!.objectForKey("dateOfBirth") as! String
    static var currentUserFitnessLevel = currentUser!.objectForKey("fitnessLevelNumber") as! String
    static var currentUserFitnessGoals = currentUser!.objectForKey("fitnessGoal") as! String
    static var currentUserProfilePic: PFFile = currentUser!.objectForKey("profilePicture") as! PFFile
    
}

var currentUser = PFUser.currentUser()
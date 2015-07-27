//
//  AppDelegate.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/18/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import CoreData
import Parse
import SystemConfiguration
import MapKit
import CoreLocation

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    let stripePublishableKey: String = "pk_test_fCWbkrhPnus6sQftk6yX47Qk"
    
    var window: UIWindow?
    var locationManager: CLLocationManager!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Stripe.setDefaultPublishableKey(stripePublishableKey)
        
        Parse.setApplicationId("sCsLLNAEyIqKPb7CtvGwAqNYQWR3XRUku6n6D9ew", clientKey: "Rm9kqIGX9othZGwn1hrEXEKcly1uF0kUZhy2TeH1")
        
        let currentUser = PFUser.currentUser()
        if currentUser != nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewControllerWithIdentifier("beginningTabBarStarter") as! UIViewController
            
            self.window?.rootViewController = initialViewController
            
            self.window?.makeKeyAndVisible()
            
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let initialViewController = storyboard.instantiateViewControllerWithIdentifier("ReachFitSignUp") as! UIViewController
            
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

}


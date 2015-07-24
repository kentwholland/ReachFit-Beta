//
//  MyFitnessViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse
import ParseUI
import Bolts

class MyFitnessViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!
    
    @IBOutlet weak var upcomingMyFitnessView: UIView!
    @IBOutlet weak var pastMyFitnessView: UIView!
    @IBOutlet weak var myFitnessSegmentController: UISegmentedControl!

    @IBAction func myFitnessSegmentControllerSelect(sender: UISegmentedControl) {
        
        switch myFitnessSegmentController.selectedSegmentIndex {
            
        case 0:
            upcomingMyFitnessView.hidden = false
            pastMyFitnessView.hidden = true
        case 1:
            upcomingMyFitnessView.hidden = true
            pastMyFitnessView.hidden = false
        default:
            break
            
        }
        
    }
    
    func updateLocation() {
        
        if currentLoc.longitude == 0 && currentLoc.latitude == 0 {
            
            currentLoc = PFGeoPoint(location: manager.location)
            println(currentLoc)
            
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        myFitnessSegmentController.selectedSegmentIndex = 0;
        upcomingMyFitnessView.hidden = false
        pastMyFitnessView.hidden = true
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        var timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("updateLocation"), userInfo: nil, repeats: true)
        
    }

}

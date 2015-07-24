//
//  MapViewController.swift
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

var currentLoc: PFGeoPoint = PFGeoPoint()

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var query: PFQuery = PFQuery()
    var manager:CLLocationManager!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        query = PFQuery(className: "WorkoutClasses")
        query.whereKey("dateOfClass", greaterThanOrEqualTo: NSDate())
        query.whereKey("classes", nearGeoPoint: currentLoc, withinMiles: 400)
        
        query.findObjectsInBackgroundWithBlock {
            (posts, error) -> Void in
            if error == nil {
                
                let myPosts = posts as! [PFObject]
                
                for post in myPosts {
                    let point = post["classes"] as! PFGeoPoint
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2DMake(point.latitude, point.longitude)
                    self.mapView.addAnnotation(annotation)
                }
            } else {
                // Log details of the failure
                println("Error: \(error)")
            }
        }
        
        println(currentLoc)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}


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
                    
                    var subtitleString: String = String()
                    
                    if let dateObject = post["dateOfClass"] as? NSDate {
                        
                        var dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm a"
                        var dateNSDate: String = dateFormatter.stringFromDate(dateObject)
                        subtitleString = dateNSDate
                        
                    }
                    
                    let point = post["classes"] as! PFGeoPoint
                    
                    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
                    var workoutClassName: String = post.objectForKey("workoutClassName") as! String
                    var workoutClassInstructor: String = post.objectForKey("instructorName") as! String
                    var objectsID: String = post.objectId! as String
                    var annotation: MapPin = MapPin(coordinate: coordinate, title: "\(workoutClassName), \(workoutClassInstructor)", subtitle: "\(subtitleString)", annotationID: "\(objectsID)")
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
        
        mapView.showsUserLocation = true
        
        var latitude: CLLocationDegrees = currentLoc.latitude
        
        var longitude: CLLocationDegrees = currentLoc.longitude
        
        var latDelta:CLLocationDegrees = 0.7
        
        var lonDelta:CLLocationDegrees = 0.7
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: false)
        
    }
    
}


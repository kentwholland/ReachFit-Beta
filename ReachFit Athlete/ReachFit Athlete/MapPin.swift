//
//  MapPin.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 7/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import MapKit

class MapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var annotationID: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, annotationID: String) {
        
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.annotationID = annotationID
        
    }
}
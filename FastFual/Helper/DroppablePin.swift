//
//  DroppablePin.swift
//  Chefs
//
//  Created by Mac on 7/19/18.
//  Copyright © 2018 Basim. All rights reserved.
//



import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
        super.init()
    }
}

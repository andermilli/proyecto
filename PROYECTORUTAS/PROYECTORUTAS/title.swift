//
//  ViewController.swift
//  PROYECTORUTAS
//
//  Created by  on 28/01/2020.
//  Copyright © 2020 Ander. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift
import Realm
class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapview: MKMapView!
    let locationManager = CLLocationManager()
    var locaciones : [CLLocationCoordinate2D] = []
   public var realm: Realm!
    override func viewDidLoad() {
        self.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
            mapview.showsUserLocation = true
        }
    
        
    }

}
//Define Location class:

public class Location: Object {
    dynamic var latitude = 0.0
    dynamic var longitude = 0.0

    /// Computed properties are ignored in Realm
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
}
//And object that persists them:

public class SomeObject: Object {
    let coordinates = List<Location>()
}
//And you will be able to access CLLocationCoordinate2D via coordinate property. For example:

//someObject.coordinates[0].coordinate



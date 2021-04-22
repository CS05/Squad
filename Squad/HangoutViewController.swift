//
//  HangoutViewController.swift
//  Squad
//
//  Created by Christian Stiker on 4/21/21.
//

import UIKit
import MapKit
import CoreLocation

class HangoutViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {

    var mapCenter: CLLocationCoordinate2D?
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: mapCenter!, span: span)
        mapView.setRegion(region, animated: false)
        
    }

}

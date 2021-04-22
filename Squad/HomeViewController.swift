//
//  HomeViewController.swift
//  Squad
//
//  Created by Christian Stiker on 4/19/21.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var meetingsTableView: UITableView!
    @IBOutlet weak var centerButton: UIButton!
    
    var centerLocation = false
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()

            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }

            mapView.delegate = self
            mapView.mapType = .standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true

            if let coor = mapView.userLocation.location?.coordinate {
                mapView.setCenter(coor, animated: true)
            }
        
            addCenterFunc()
        
        mapView.pointOfInterestFilter = .includingAll
    }
    
    func addCenterFunc() {
        centerButton.addTarget(self, action: #selector(centerMapOnUserButtonClicked), for:.touchUpInside)
    }
    
    
    @objc func centerMapOnUserButtonClicked() {
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func plusPressed(_ sender: Any) {
        print("Plus pressed")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        let userLocation:CLLocation = locations[0] as CLLocation
        
        locationManager.stopUpdatingLocation()
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        //centerMap(locValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "HomeToHangout"{
                let vc = segue.destination as! HangoutViewController
                vc.mapCenter = self.mapView.convert(mapView.center, toCoordinateFrom: mapView)
            }
        }
    }


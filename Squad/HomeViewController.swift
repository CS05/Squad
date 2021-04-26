//
//  HomeViewController.swift
//  Squad
//
//  Created by Christian Stiker on 4/19/21.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var meetingsTableView: UITableView!
    @IBOutlet weak var centerButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
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
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        //centerMap(locValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "HomeToHangout"{
                let vc = segue.destination as! HangoutViewController
                vc.mapCenter = mapView.centerCoordinate
                vc.zoomLevel = mapView.cameraZoomRange
            }
        }
    
    
//MARK: Table View
    
    let hangouts: [String] = []
        
        // cell reuse id (cells that scroll out of view can be reused)
        let cellReuseIdentifier = "cell"
        
        // number of rows in table view
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.hangouts.count
        }
        
        // create a cell for each table view row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // create a new cell if needed or reuse an old one
            let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UITableViewCell
            
            // set the text from the data model
            cell.textLabel?.text = self.hangouts[indexPath.row]
            
            return cell
        }
        
        // method to run when table view cell is tapped
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.row).")
        }
    
    }


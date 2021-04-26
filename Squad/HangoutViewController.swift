//
//  HangoutViewController.swift
//  Squad
//
//  Created by Christian Stiker on 4/21/21.
//

import UIKit
import MapKit
import CoreLocation

class HangoutViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var mapCenter: CLLocationCoordinate2D?
    var zoomLevel: MKMapView.CameraZoomRange?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var numberPicker: UIPickerView!
    @IBOutlet weak var formatPicker: UIPickerView!
    
    @IBOutlet weak var friend1: UIButton!
    @IBOutlet weak var friend2: UIButton!
    @IBOutlet weak var friend3: UIButton!
    @IBOutlet weak var friend4: UIButton!
    @IBOutlet weak var friend5: UIButton!
    @IBOutlet weak var friend6: UIButton!
    @IBOutlet weak var friend7: UIButton!
    @IBOutlet weak var friend8: UIButton!
    @IBOutlet weak var friend9: UIButton!
    
    @IBAction func friendToggled(_ sender: UIButton) {
        if sender.backgroundColor == UIColor(named: "AppMediumBlue") {
            sender.backgroundColor = UIColor(named: "AppDarkBlue")
        } else {
            sender.backgroundColor = UIColor(named: "AppMediumBlue")
        }
    }
    
    let locationManager = CLLocationManager()
    
    var numberPickerData: [String] = [String]()
    var formatPickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapType = .standard
        mapView.pointOfInterestFilter = .includingAll
        
        mapView.delegate = self
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let region = MKCoordinateRegion(center: mapCenter!, span: span)
        
        mapView.setRegion(region, animated: false)
        
        datePicker.addTarget(self, action: #selector(HangoutViewController.handler(sender:)), for: UIControl.Event.valueChanged)
        
        numberPickerData = ["1", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60"]
        
        formatPickerData = ["minute(s)", "hour(s)"]
        
        self.numberPicker.delegate = self
        self.numberPicker.dataSource = self
        
        self.formatPicker.delegate = self
        self.formatPicker.dataSource = self
        
    }

//MARK: Picker View
    
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }

      // Number of columns of data
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      // The number of rows of data
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return numberPickerData.count
        } else {
            return formatPickerData.count
        }
          
      }
      
      // The data to return fopr the row and component (column) that's being passed in
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return numberPickerData[row]
        } else {
            return formatPickerData[row]
        }
          
      }
    
    
    @objc func handler(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.dateStyle = DateFormatter.Style.short

        var strDate = timeFormatter.string(from: datePicker.date)
        print(strDate)
        // do what you want to do with the string.
    }
    
    
}

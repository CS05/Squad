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
        
        numberPickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
        
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
    
    var strDate = ""
    
    @objc func handler(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.dateStyle = DateFormatter.Style.short

        strDate = timeFormatter.string(from: datePicker.date)
        // do what you want to do with the string.
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        HangoutLib.hangouts.append("Hangout at \(strDate)")
        self.dismiss(animated: true, completion: nil)
    }
    
}

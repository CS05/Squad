//
//  HomeViewController.swift
//  Squad
//
//  Created by Christian Stiker on 4/19/21.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var meetingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func plusPressed(_ sender: Any) {
        print("Plus pressed")
    }
    
    
    
}

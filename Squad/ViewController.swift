//
//  ViewController.swift
//  Squad
//
//  Created by Christian Stiker on 4/18/21.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerPressed(_ sender: Any) {
        if emailField.text == nil || passwordField.text == nil {
            print("Must enter password or email")
        }
        else {
            let email = emailField.text!
            let password = passwordField.text!
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "LandingToHome", sender: self)
                }
            }
        }
        
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
    }
    
    
}


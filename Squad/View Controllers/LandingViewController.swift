//
//  ViewController.swift
//  Squad
//
//  Created by Christian Stiker on 4/18/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LandingViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerPressed(_ sender: Any) {
        if emailField.text == "" || passwordField.text == "" {
            errorLabel.text = "Must enter password or email"
        }
        else {
            let email = emailField.text!
            let password = passwordField.text!
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    self.errorLabel.text = e.localizedDescription
                } else {
                    self.errorLabel.text = ""
                    self.performSegue(withIdentifier: "LandingToHome", sender: self)
                }
            }
        }
        
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        if emailField.text == "" || passwordField.text == "" {
            errorLabel.text = "Must enter password or email"
        }
        else {
            let email = emailField.text!
            let password = passwordField.text!
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
                if let e = error {
                    print(e)
                    self?.errorLabel.text = e.localizedDescription
                } else {
                    self?.errorLabel.text = ""
                    self?.performSegue(withIdentifier: "LandingToHome", sender: self)
                }
            }
    }
    
    
}

}

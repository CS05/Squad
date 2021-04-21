//
//  ViewController.swift
//  Squad
//
//  Created by Christian Stiker on 4/18/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    let rememberPassword = true
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        if rememberPassword {
            let defaults = UserDefaults.standard
            if let email = defaults.string(forKey: "email"){
                emailField.text = email
            }
            if let password = defaults.string(forKey: "password"){
                passwordField.text = password
            }
        }
    }

    @IBAction func registerPressed(_ sender: Any) {
        if emailField.text == "" || passwordField.text == "" {
            errorLabel.text = "Must enter password or email"
        }
        else {
            let defaults = UserDefaults.standard
            let email = emailField.text!
            let password = passwordField.text!
            
            defaults.set(email, forKey: "email")
            defaults.set(password, forKey: "password")
            
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
            let defaults = UserDefaults.standard
            let email = emailField.text!
            let password = passwordField.text!
            
            defaults.set(email, forKey: "email")
            defaults.set(password, forKey: "password")
            
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

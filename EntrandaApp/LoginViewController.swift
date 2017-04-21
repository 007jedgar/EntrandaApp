//
//  LoginViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/21/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func signupButtonPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
     
        
    }
    
    //login or signup auth field completed
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        let okAction = UIAlertAction(title: "Got It!", style: .default , handler: nil)
        let nameAlert = UIAlertController(title: "Missing Name", message: "Check out the name field...it's what you're friends call you", preferredStyle: .alert)
        nameAlert.addAction(okAction)
        
        let emailAlert = UIAlertController(title: "Missing Email", message: "Check out the name field...it's where your uncle sends you his conspiracy theories", preferredStyle: .alert)
        emailAlert.addAction(okAction)
        
        let passwordAlert = UIAlertController(title: "Missing Password", message: "Check out the password field...we need it to do all of our code magic", preferredStyle: .alert)
        passwordAlert.addAction(okAction)
        
        let passwordsDontMatchAlert = UIAlertController(title: "Passwords Don't Match", message: "Check out your passwords...let's get this right now", preferredStyle: .alert)
        passwordsDontMatchAlert.addAction(okAction)
        
        guard let name = self.nameTextField.text, !name.isEmpty else {
            present(nameAlert, animated: true, completion: nil)
            return
        }
        
        guard let email = self.nameTextField.text, !email.isEmpty else {
            present(emailAlert, animated: true, completion: nil)
            return
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            present(passwordAlert, animated: true, completion: nil)
            return
        }
        guard let confirmation = self.confirmationTextField.text, !confirmation.isEmpty, confirmation == password else {
            present(passwordsDontMatchAlert,animated: true, completion: nil)
            return
        }
        let guide = Guide(name: name, email: email, password: confirmation)
        print("\(guide.name, guide.email)")
        authorizeUser(authInfo: guide)
    }
    
    func authorizeUser(authInfo: Guide) {
        let dictionary = ["name": authInfo.name, "email": authInfo.email]
        print("Got some data for: \(dictionary)")
    }
}

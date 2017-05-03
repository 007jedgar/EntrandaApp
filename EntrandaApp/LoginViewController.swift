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

enum SignInOptions {
    case login
    case signup
}

class LoginViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmationTextField: UITextField!
    @IBOutlet weak var doneButtonPressed: UIButton!
    
    @IBOutlet weak var nameTableViewCell: UITableViewCell!
    @IBOutlet weak var confirmationTableViewCell: UITableViewCell!
    @IBOutlet weak var emailTableViewCell: UITableViewCell!
    @IBOutlet weak var passwordTableViewCell: UITableViewCell!
    @IBOutlet weak var doneTableViewCell: UITableViewCell!
    var isRegistered: Bool = false
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confirmationTableViewCell.frame.size.height = 0
        self.nameTableViewCell.frame.size.height = 0
        self.emailTableViewCell.frame.size.height = 0
        self.passwordTableViewCell.frame.size.height = 0
        self.doneTableViewCell.frame.size.height = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //should hide the cells
        self.confirmationTableViewCell.frame.size.height = 0
        self.nameTableViewCell.frame.size.height = 0
        self.emailTableViewCell.frame.size.height = 0
        self.passwordTableViewCell.frame.size.height = 0
        self.doneTableViewCell.frame.size.height = 0
    }

    @IBAction func signupButtonPressed(_ sender: Any) {
        //unhide cells that contain text fields
        counter += 1
        isRegistered = false
        nameTableViewCell.frame.size.height = 60
        confirmationTableViewCell.frame.size.height = 60
        emailTableViewCell.frame.size.height = 60
        passwordTableViewCell.frame.size.height = 60
        doneTableViewCell.frame.size.height = 69
        
        self.doneButtonPressed.titleLabel?.text = "Sign Up!"
        
        //easter egg
        if counter >= 4 {
            
        }
    }
    
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        //unhide cells that contain text fields
        counter += 1
        isRegistered = true
        emailTableViewCell.frame.size.height = 60
        passwordTableViewCell.frame.size.height = 60
        doneTableViewCell.frame.size.height = 69
        nameTableViewCell.frame.size.height = 0
        confirmationTableViewCell.frame.size.height = 0
        
        self.doneButtonPressed.titleLabel?.text = "Login!"

        //easter egg
        if counter >= 4 {
        
        }
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
        
        //checks for empty text fields
        guard let name = self.nameTextField.text, !name.isEmpty else {
            present(nameAlert, animated: true, completion: nil)
            return
        }
        guard let email = self.emailTextField.text, !email.isEmpty else {
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
        
        //checks if signup or login was selected
        if self.isRegistered == false {
        let guide = Guide(name: name, email: email, password: confirmation)
        print("\(guide.name, guide.email)")
        authorizeUser(authInfo: guide)
        
            //Firebase Authentication
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in

            if error != nil {
                print("Auth failed")
                return
            }else{}
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                //auth listener waits for user to be authenticated to perform segue
                FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
                    if user != nil {
                        //perform segue
                        }
                    }
                }
            }
        } else {
            FIRAuth.auth()!.signIn(withEmail: email,
                                   password: password)
                            //auth listener waits for user to be authenticated to perform segue
            FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
                if user != nil {
                    //perform segue
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    //Random useless function...
    func authorizeUser(authInfo: Guide) {
        let dictionary = ["name": authInfo.name, "email": authInfo.email]
        print("Got some data for: \(dictionary)")

    }
    
    
}

extension UIColor {
    
    static func colorWithoutSweat(r: CGFloat, g: CGFloat, b: CGFloat) -> CGColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1) as! CGColor
    }
}


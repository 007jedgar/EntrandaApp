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
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var authOptionSegmentControll: UISegmentedControl!
    
    @IBOutlet weak var nameTableViewCell: UITableViewCell!
    @IBOutlet weak var confirmationTableViewCell: UITableViewCell!
    @IBOutlet weak var emailTableViewCell: UITableViewCell!
    @IBOutlet weak var passwordTableViewCell: UITableViewCell!
    @IBOutlet weak var doneTableViewCell: UITableViewCell!
    var isRegistered: Bool = false
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //should hide the cells
        self.confirmationTableViewCell.frame.size.height = 0
        self.nameTableViewCell.frame.size.height = 0
        self.emailTableViewCell.frame.size.height = 60
        self.passwordTableViewCell.frame.size.height = 60
        self.doneTableViewCell.frame.size.height = 69
        self.authOptionSegmentControll.frame.size.height = 36
    }
    
    @IBAction func authIndexChanged(_ sender: Any) {
        
        switch authOptionSegmentControll.selectedSegmentIndex {
        case 0:
            isRegistered = true
            emailTableViewCell.frame.size.height = 60
            passwordTableViewCell.frame.size.height = 60
            doneTableViewCell.frame.size.height = 69
            nameTableViewCell.frame.size.height = 0
            confirmationTableViewCell.frame.size.height = 0
            changeButtonText(text: "Login")
        case 1:
            isRegistered = false
            doneTableViewCell.frame.size.height = 69
            nameTableViewCell.frame.size.height = 60
            emailTableViewCell.frame.size.height = 60
            passwordTableViewCell.frame.size.height = 60
            confirmationTableViewCell.frame.size.height = 60
            changeButtonText(text: "Sign Up")
        default:
            break
        }
    }
    
    func changeButtonText(text: String) {
        self.doneButton.setTitle(text, for: .normal)
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
        
        //For Sign up login or signup? Segment index 1 is signup
        if authOptionSegmentControll.selectedSegmentIndex == 1 {
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
            let guide = Guide(name: name, email: email, password: confirmation)
            print("\(guide.name, guide.email)")
            authorizeUser(authInfo: guide)
            
            //Firebase Authentication
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                        switch errCode {
                        case .errorCodeEmailAlreadyInUse:
                            print("email already in user")
                        case .errorCodeWeakPassword:
                            print("Weak password bruh")
                        default:
                            print("Auth failed: \(String(describing: error))")
                            break
                        }
                    }
                    return
                } else {
                    FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
                            if user != nil {
                                //perform segue
                                let currentUserUID = FIRAuth.auth()?.currentUser?.uid
                                let Userref = FIRDatabase.database().reference().child("user")
                                
                                let date = Date()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "dd.MM.yyyy"
                                let timeCreated = formatter.string(from: date)
                                
                                let currentUserRef = Userref.child(currentUserUID!)
                                currentUserRef.child("name").setValue("\(guide.name)")
                                let channelsRef = currentUserRef.child("channels")
                                channelsRef.child("channel1").setValue("")
                                self.navigationController?.popViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        } else { //For Login 

        self.nameTextField.text = nil
        self.confirmationTextField.text = nil
        guard let email = self.emailTextField.text, !email.isEmpty else {
            present(emailAlert, animated: true, completion: nil)
            return
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            present(passwordAlert, animated: true, completion: nil)
            return
        }

            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in

                if error != nil { //There's an error...
                    let loginAlert = UIAlertController(title: "Uh Oh...", message: "\(error.debugDescription)", preferredStyle: .alert)
                    let gotchaAlert = UIAlertAction(title: "Gotcha!", style: .default, handler: nil)
                    loginAlert.addAction(gotchaAlert)
                    print("Error: \(error.debugDescription)")
                    
                    } else { //Everything's good!
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    //Random useless function...checks object
    func authorizeUser(authInfo: Guide) {
        let dictionary = ["name": authInfo.name, "email": authInfo.email]
        print("Got some data for: \(dictionary)")
    }
}

//Was really just testing this out
extension UIColor {
    static func colorWithoutSweat(r: CGFloat, g: CGFloat, b: CGFloat) -> CGColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1) as! CGColor
    }
}


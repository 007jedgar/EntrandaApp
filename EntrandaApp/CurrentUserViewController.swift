//
//  CurrentUserViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 5/8/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CurrentUserViewController: UITableViewController {
    
    @IBOutlet weak var profileImgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //self.profileImgView.layer.cornerRadius = self.profileImgView.layer.frame.size.width / 5
    }
    
    @IBAction func logout() {
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}

//
//  GuideProfileTableViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/13/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class GuideProfileTableViewController: UITableViewController {

        @IBOutlet weak var profileImgView: UIImageView!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var locationLabel: UILabel!
        @IBOutlet weak var bioLabel: UILabel!
        @IBOutlet weak var phoneNumberLabel: UILabel!
        @IBOutlet weak var emailLabel: UILabel!
        @IBOutlet weak var linksLabel: UILabel!
    
    let guideTVC = GuideTableViewController()
    
    var guide :Guide!
    
    var ref: FIRDatabaseReference!
    var name = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bioLabel?.text = guide.bio
        self.locationLabel?.text = guide.location
        self.nameLabel?.text = guide.name
        self.phoneNumberLabel?.text = guide.phoneNumber
        self.emailLabel?.text = guide.email

        
    }

    // Populate the guide profile page
    @IBAction func backButtonPressed(_ sender: Any) {
        
    }
    
}

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

class GuideProfileTableViewController: UITableViewController, SendDataDelegate {

        @IBOutlet weak var profileImgView: UIImageView!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var locationLabel: UILabel!
        @IBOutlet weak var bioLabel: UILabel!
        @IBOutlet weak var phoneNumberLabel: UILabel!
        @IBOutlet weak var emailLabel: UILabel!
        @IBOutlet weak var linksLabel: UILabel!
    
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func sendData(guideInfo: Guide) {
        
        self.nameLabel?.text = guideInfo.name
        self.emailLabel?.text = guideInfo.email
    }
    

    // Populate the guide profile page
    @IBAction func backButtonPressed(_ sender: Any) {
        
    }
    
}

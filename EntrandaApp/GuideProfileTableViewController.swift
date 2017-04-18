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
    
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        getDataFromFirebase()
    }
    
    // Get Data from Firebase -> Class/Object
    func getDataFromFirebase() {
        
        ref = FIRDatabase.database().reference()
        let guideRef = self.ref.child("Guide").child("User Id")

        guideRef.observe(FIRDataEventType.value, with: { (snapshot: FIRDataSnapshot) in

            let guideData = snapshot.value as? [String: Any]
            
            for snap in snapshot.children {
                print("Found \(snap)")
                let guideName = guideData?["Name"] as! String
                print(guideName)
            }
        
        })
    }

    // Populate the guide profile page
    func populatePage() {
        
        
    }
    
}

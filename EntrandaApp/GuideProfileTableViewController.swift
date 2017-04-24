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

class GuideProfileTableViewControll: UITableViewController {

        @IBOutlet weak var profileImgView: UIImageView!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var bioLabel: UILabel!
        @IBOutlet weak var phoneNumberButton: UIButton!
        @IBOutlet weak var emailLabel: UILabel!
        @IBOutlet weak var linksLabel: UILabel!
        @IBOutlet weak var tourBioLabel: UILabel!
        @IBOutlet weak var locationLabel: UILabel!
    
    let guideTVC = GuideTableViewControl()
    
    var guide :Guide!
    
    var ref: FIRDatabaseReference!
    var name = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bioLabel?.text = guide.bio
        self.locationLabel?.text = guide.location
        self.nameLabel?.text = guide.name
        self.phoneNumberButton?.setTitle(guide.phoneNumber, for: .normal)
        self.emailLabel?.text = guide.email
        self.tourBioLabel?.text = guide.tourBio
        let photoURL = guide.pictureURL
        print("\(guide.pictureURL)")
        let url = URL(string: photoURL)
        
        // In case image doesnt upload to firebase correctly
        if photoURL == "" {
            self.profileImgView.image = #imageLiteral(resourceName: "userIcon")
        } else {
            self.profileImgView.kf.setImage(with: url)
        }

        self.profileImgView.layer.cornerRadius = profileImgView.layer.frame.size.width / 5
        self.profileImgView.clipsToBounds = true
        
    }

    // Populate the guide profile page
    @IBAction func backButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func callButtonPressed(_ sender: Any) {
        let MessageGuide = UIAlertController(title: "Message Guide", message: "Open Phone App", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Call", style: .default) { (UIAlertAction) in
            if let phoneCallURL = URL(string: "tel://\(self.guide.phoneNumber)") {
                
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        MessageGuide.addAction(okAction)
        MessageGuide.addAction(cancel)
        
    }
    
    
    
}

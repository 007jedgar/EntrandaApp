//
//  CurrentUserViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 5/8/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CurrentUserViewController: UITableViewController {
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var logoutBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var bioTableViewCell : UITableViewCell!
    
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        if FIRAuth.auth()?.currentUser != nil {
            populateProfile()
            
            self.profileImgView.layer.cornerRadius = self.profileImgView.layer.frame.size.width / 7;
            self.profileImgView.clipsToBounds = true
            
        } else {
            performSegue(withIdentifier: "ProfileAuth", sender: nil)
        }
        self.navigationItem.title = "Profile"
      
    }
    
    @IBAction func logout() {
        if FIRAuth.auth()?.currentUser != nil {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            }
        }
        
        //present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
    
    func populateProfile() {
        let current = FIRAuth.auth()?.currentUser?.uid
        ref = FIRDatabase.database().reference().child("guide").child(current!)

        ref.observe(FIRDataEventType.value, with: { (snapshot: FIRDataSnapshot) in
            let guideInfo = snapshot.value as! [String: Any]
            let guide = Guide(dictionary: guideInfo)
            self.nameLabel.text = guide.name
            self.bioLabel.text = guide.bio
            self.locationLabel.text = guide.location
            
            DispatchQueue.global().async {
                let guideURL = guide.pictureURL
                DispatchQueue.main.async {
                    let url = URL(string: guideURL)
                    self.profileImgView.kf.setImage(with: url)
                }
            }
        })
    }
}

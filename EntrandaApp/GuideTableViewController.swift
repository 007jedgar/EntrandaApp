//
//  GuideTableViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/13/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Guide {
    
    var name = String()
    var pictureURL = UIImage()
    var bio = String()
    var age = String()
    
    var location = String()
    var tags = [String]()
    var phoneNumber = String()
    var links = String()
    
    var pricing = String()
    var tourBio = String()
    var email = String()
    var gender = String()
    
    init(snapshot :FIRDataSnapshot) {
        
        let snapShotValue = snapshot.value as! [String:Any]
        
        guard let email = snapShotValue["email"] as? String,
              let gender = snapShotValue["gender"] as? String,
              let age = snapShotValue["age"] as? String,
              let name = snapShotValue["name"] as? String,
              let phoneNumber = snapShotValue["phone number"] as? String,
              let tourBio = snapShotValue["tour bio"] as? String
        else {
            fatalError("email is not found")
        }
        
        self.email = email
        self.gender = gender
        self.age = age
        self.name = name
        self.tourBio = tourBio
        self.phoneNumber = phoneNumber
        
    }
    
    init(name: String, bio: String, age: String, location: String, email: String, gender: String, tourInfo: String){
        self.name = name
        self.bio = bio
        self.age = age
        self.location = location
        self.email = email
        self.gender = gender
        self.tourBio = tourInfo
    }
    
    init() {
    }
}

class GuideTableViewController: UITableViewController {

    var guides = [Guide]()
    var ref: FIRDatabaseReference!
    var selectedProfile = Guide()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateGuide()
        self.tableView.reloadData()
    }

    //Pull from Firebase -> guides -> self.tableView
    func populateGuide() {
    ref = FIRDatabase.database().reference()
        let guideRef = ref.child("guide")
        
        guideRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            
            for snap in snapshot.children {
                print(snap)
                let guide = Guide(snapshot: snap as! FIRDataSnapshot)
                
               // print(dictionary["email"]!)
                self.guides.append(guide)
            }
            
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guides.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuideCell", for: indexPath) as! GuideTableViewCell
        
        let guide = guides[indexPath.row]
        cell.guideQuickBioLabel.text = guide.bio
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedProfile = guides[indexPath.row]
        
        performSegue(withIdentifier: "GuideProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier) == "GuideProfile" {
            let top  = segue.destination as! UINavigationController
            let vc = top.topViewController as! GuideProfileTableViewController
            
            vc.bioLabel?.text = selectedProfile.bio
            vc.locationLabel?.text = selectedProfile.location
            vc.nameLabel?.text = selectedProfile.name
            vc.phoneNumberLabel?.text = selectedProfile.phoneNumber
            vc.emailLabel?.text = selectedProfile.email
            
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
    
        
    }
}

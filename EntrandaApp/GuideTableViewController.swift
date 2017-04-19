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
    
    init(dictionary: [String: Any]) {
        
        guard let email = dictionary["email"] as? String,
            let gender = dictionary["gender"] as? String,
            let age = dictionary["age"] as? String,
            let name = dictionary["name"] as? String,
            let phoneNumber = dictionary["phone number"] as? String,
            let tourBio = dictionary["tour bio"] as? String
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
    
    func toDictionary() -> [String:Any] {
        return
        [ "email":self.email,
          "age":self.age,
            "name":self.name,
            "phone number":self.phoneNumber,
            "bio":self.bio,
            "tour bio":self.tourBio,
            "gender":self.gender,
            "location":self.location
        ]
    }
    
    init(snapshot: [String: Any]) {
        
        guard let name = snapshot["name"] as? String else{
            fatalError("name not found")
        }
        guard let email = snapshot["email"] as? String else{
            fatalError("email not found")
        }
        guard let phoneNumber = snapshot["phone number"] as? String else{
            fatalError("phone number not found")
        }
        guard let gender = snapshot["gender"] as? String else{
            fatalError("gender not found")
        }
        guard let age = snapshot["age"] as? String else{
            fatalError("age not found")
        }
        guard let bio = snapshot["bio"] as? String else{
            fatalError("bio not found")
        }
        guard let tourBio = snapshot["tour bio"] as? String else{
            fatalError("tour bio not found")
        }
        
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.age = age
        self.bio = bio
        self.tourBio = tourBio
    }
    
    
    init() {
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
            
            for item in snapshot.children {
                
                let snap = item as! FIRDataSnapshot
                let snapShotValue = snap.value as! [String:Any]
                
              //  let dictionary = snapShotValue as! [String: Any]
                //print(dictionary)
                
                let guide = Guide(snapshot: snapShotValue)
                self.guides.append(guide)
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.guides.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuideCell", for: indexPath) as! GuideTableViewCell
        
        let guide = guides[indexPath.row]
        cell.guideQuickBioLabel?.text = guide.name
        cell.guideRatingLabel?.text = guide.bio
        cell.guideProfileImgView?.image = #imageLiteral(resourceName: "userIcon")
        print("Found: \(guide.name)")
        self.navigationItem.title = guide.location

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProfile = guides[indexPath.row]
        print(guides[indexPath.row])
        performSegue(withIdentifier: "GuideProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier) == "GuideProfile" {
            let top  = segue.destination as! UINavigationController
            let vc = top.topViewController as! GuideProfileTableViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let guide = guides[indexPath.row]
                
                vc.guide = guide
                

                print("Found: \(guide.bio)")
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let vc = CityGuideTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

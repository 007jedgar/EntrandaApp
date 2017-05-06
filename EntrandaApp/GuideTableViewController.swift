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
import Kingfisher

class GuideTableViewControl: UITableViewController {

    var guides = [Guide]()
    var ref: FIRDatabaseReference!
    var selectedProfile = Guide()
    var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateGuide()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let cityTitle = self.city.cityTitle
        self.navigationItem.title = cityTitle
    }

    //Pull from Firebase -> guides -> self.tableView
    func populateGuide() {
    ref = FIRDatabase.database().reference()
        let guideRef = ref.child("guide")
        
        guideRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            self.guides.removeAll()
            for item in snapshot.children {
                
                let snap = item as! FIRDataSnapshot
                let snapShotValue = snap.value as! [String:Any]

                
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
        
        if guide.pictureURL == "" {
            cell.guideProfileImgView.image = #imageLiteral(resourceName: "userIcon")
        } else {
            let photoURL = guide.pictureURL
            let url = URL(string: photoURL)
            cell.guideProfileImgView.kf.setImage(with: url)
        }
        
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

            let vc = segue.destination as! GuideProfileTableViewControll
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let guide = guides[indexPath.row]
                
                vc.guide = guide
                
                print("Found: \(guide.pictureURL)")
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let vc = CityGuideTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

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

class GuideTableViewController: UITableViewController {

    var guides = [Guide]()
    var ref: FIRDatabaseReference!
    var selectedProfile = Guide()
    var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateGuide()
        self.title = "kit-kat"
        self.navigationItem.title = "Cherio"
        
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

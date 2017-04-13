//
//  LocalGuidesTableViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/7/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage

class LocalGuidesTableViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource {
    var ref: FIRDatabaseReference!

    @IBOutlet weak var tableView: UITableView!
    var guides = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        getGuideInfo()
    }

    func getGuideInfo() {
//        
//        ref = FIRDatabase.database().reference()
//        let user = ref.child("User")
//        guides.append(contentsOf: user)
//        
//        refHandle = postRef.observe(FIRDataEventType.value, with: { (snapshot) in
//            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            
//            
//        })
    }
    
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.guides.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let guide  = guides[indexPath.row]
        cell.textLabel?.text = guide.name
        return cell
    }
 


}

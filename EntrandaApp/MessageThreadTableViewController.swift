//
//  MessageThreadTableViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/7/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Kingfisher

class MessageThreadTableViewController: UITableViewController {

    var ref: FIRDatabaseReference!
    let threads = [MessageThread]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageThreadPopulate()
    }

    func messageThreadPopulate() {
        
        ref = FIRDatabase.database().reference()
        
        ref.child("ChatRoom1").child("messages").child("hello World")
        
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.threads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatThread", for: indexPath) as! MessageThreadCell
        
        let thread = self.threads[indexPath.row]
        cell.nameLabel.text = thread.channelName
        return cell
    }
 

 

}

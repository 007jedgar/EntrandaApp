//
//  MessageThreadTableViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/7/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//
//
/*  
                            // View Summary //
 
 The message thread page should be a tableview that contains information about the
 message threads that are active between two or more users. It should show who at 
 least two people in the chatroom, the last message sent, and when it was recieved.

 
*/

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.threads.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatThread", for: indexPath) as! MessageThreadCell
        
        let thread = self.threads[indexPath.row]
        cell.nameLabel.text = thread.channelName
        return cell
    }
}

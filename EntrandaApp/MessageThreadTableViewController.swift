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
import FirebaseAuth


class MessageThreadTableViewController: UITableViewController {

    // MARK: Properties
    var senderDisplayName: String?
    var newChannelTextField: UITextField?
    var channels = [Channel]()
    
    var ref: FIRDatabaseReference!
    var count : Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Conversations"
        observeChannels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.tableView.reloadData()
        
        if FIRAuth.auth()?.currentUser != nil {
            //let user = FIRAuth.auth()?.currentUser
            //print("Found: \(String(describing: user?.email))")
        } else {
            performSegue(withIdentifier: "SignInFirst", sender: nil)
        }
    }
    
    func makeConversation() {
        let convoRef = ref?.child("conversations").childByAutoId()
        let messagesRef = convoRef?.child("conversations")
        let textMsgRef = messagesRef?.child("message")
        convoRef?.child("last message").setValue("hey")
        
        //let textMsgRef = messagesRef?.child("message\(count)")
        textMsgRef?.child("text").setValue("hey")
        textMsgRef?.child("time sent").setValue("10:34am")
        textMsgRef?.child("sender").setValue("user1")
        
    }

    // MARK: Firebase related methods
    private func observeChannels() {
        let currentUser = FIRAuth.auth()?.currentUser?.uid
        
        ref = FIRDatabase.database().reference().child("user")
        let channelRef = ref.child(currentUser!).child("channels")
        channelRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
//                let channelDictionary = snapshot.value as! [String: Any]
//                print("Found: \(channelDictionary)")
            for i in snapshot.children {
                let channelDictionary = snapshot.value as! [String: Any]
                let channelName = channelDictionary["channel1"] as! String
                let _channel = Channel(name: channelName)
                self.channels.append(_channel)
            }
        })
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func createChannel(_ sender: AnyObject) {

        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExistingChannel", for: indexPath) as! ThreadTableViewCell
        let channel = channels[indexPath.row]
        cell.channelNameLabel.text = channel.name
        
        return cell
    }
    
}

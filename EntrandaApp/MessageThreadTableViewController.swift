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

enum Section: Int {
    case createNewChannelSection = 0
    case currentChannelsSection
}


class MessageThreadTableViewController: UITableViewController {

    // MARK: Properties
    var senderDisplayName: String?
    var newChannelTextField: UITextField?
    private var channels: [Channel] = []
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Messages"
        observeChannels()
    }
    
    deinit {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
        }
    }
    
    private lazy var channelRef: FIRDatabaseReference = FIRDatabase.database().reference().child("channels")
    private var channelRefHandle: FIRDatabaseHandle?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        channels.removeAll()
        channels.append(Channel(id: "1", name: "Melissa Pruett"))
        channels.append(Channel(id: "2", name: "Steven Yuen"))
        channels.append(Channel(id: "3", name: "Gustavo Herlo"))
        self.tableView.reloadData()
        
        if FIRAuth.auth()?.currentUser != nil {
            //let user = FIRAuth.auth()?.currentUser
            //print("Found: \(String(describing: user?.email))")
        } else {
            performSegue(withIdentifier: "SignInFirst", sender: nil)
        }
    }

    // MARK: Firebase related methods
    private func observeChannels() {
        // Use the observe method to listen for new
        // channels being written to the Firebase DB
        channelRefHandle = channelRef.observe(.childAdded, with: { (snapshot) -> Void in
            let channelData = snapshot.value as! Dictionary<String, AnyObject>
            let id = snapshot.key
            if let name = channelData["name"] as! String!, name.characters.count > 0 {
                self.channels.append(Channel(id: id, name: name))
                self.tableView.reloadData()
            } else {
                print("Error! Could not decode channel data")
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    @IBAction func createChannel(_ sender: AnyObject) {
        if let name = newChannelTextField?.text {
            let newChannelRef = channelRef.childByAutoId()
            let channelItem = [
                "name": name
            ]
            newChannelRef.setValue(channelItem)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentSection: Section = Section(rawValue: section) {
            switch currentSection {
            case .createNewChannelSection:
                return 1
            case .currentChannelsSection:
                return channels.count
            }
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue ? "NewChannel" : "ExistingChannel"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue {
            if let createNewChannelCell = cell as? CreateChannelCell {
                newChannelTextField = createNewChannelCell.newChannelNameField
            }
        } else if (indexPath as NSIndexPath).section == Section.currentChannelsSection.rawValue {
            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let channel = sender as? Channel {
            let chatVc = segue.destination as! ChatViewController
            
            chatVc.senderDisplayName = senderDisplayName
            chatVc.channel = channel
            chatVc.channelRef = channelRef.child(channel.id)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "SignInFirst" {
//            //do what?
//        }
//    }
}

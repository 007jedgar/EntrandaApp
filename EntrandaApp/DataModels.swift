//
//  DataModels.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/9/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import Foundation

//users
class User {
    
    
    var id = String()
    var email = String()
    var name = String()
    var imgURL = String()
    
    var location  = String()
    var tags = [String]()
    
    init(name: String, location: String) {
        
        self.name = name
        self.location = location
    }
    
    init() {
        
    }
}

//for message thread page
class MessageThread {
    
    var client1 = String()
    var client2 = String()
    
    var timeRecieved = Date()
    
    init(client1: String, client2: String) {
        self.client1 = client1
        self.client2 = client2
    }
    
    init(timeRecieved: Date) {
        self.timeRecieved = timeRecieved
    }
    
    init() {
        
    }
}

//for chatroom
class Message {
    
    var id = String()
    var owner = DataModel()
    var members = [DataModel]()
    
    
}


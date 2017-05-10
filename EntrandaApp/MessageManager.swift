//
//  MessageManager.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/24/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import Foundation

class MessageManager {
    
    var name = String()
    var senderId = String()
    var message = String()
    var dateSent = Date()
    
    func postMessage(senderID: String, name: String, message: String, dateSent: Date) -> [String: Any] {
     
        let post = [
        "senderId": senderId,
        "name": name,
        "message": message,
        "dateSent": dateSent
        ] as [String : Any]
        
        return post
    }
    
}

 class Channel {
    
    var id = String()
    var name = String()
    var lastMessage = String()
    var userImageURL = String()
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(id: String, name: String, lastMessage: String, userImageURL: String) {
        self.name = name
        self.id = id
        self.lastMessage = lastMessage
        self.userImageURL = userImageURL
    }
    
    init(name: String) {
        self.name = name
    }
    
}

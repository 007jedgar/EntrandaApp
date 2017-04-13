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
    
    private var id = String()
    
    var gender = String()
    var userID = String()
    var email = String()
    var name = String()
    private var profileImgURL = String()
    private var phoneNumber = String()
    var rating = Int()
    var bio = String()
    var link = String()
    private var location  = String()
    private var tags = [String]()
    
    init(name: String, location: String, tags: String, phoneNumber: String, email: String, bio: String, gender: String, link: String, userID: String) {
        
        self.name = name
        self.location = location
        self.tags = [tags]
        self.phoneNumber = phoneNumber
        self.email = email
        self.bio = bio
        self.gender = gender
        self.link = link
        self.userID = userID
//        self.profileImgURL = profileImgURL         ///later
    }
    
    init() {
    }
}

//for message thread page and chatroom
class MessageThread {
    
    //for message thread
    var channelName = String()
    var newMessages = Int()
    
    //for chatroom
    var members = [User]()
    var roomOwner = User()
    var message1 = [String: String]()
    var message2 = [String: String]()
    var senderID = String()
    
}



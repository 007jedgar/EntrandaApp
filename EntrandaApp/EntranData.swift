//
//  EntranData.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/19/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import Foundation
import UIKit


class Guide {
    
    var name = String()
    var pictureURL = UIImage()
    var bio = String()
    var age = String()
    
    var location = String()
    var tags = [String]()
    var phoneNumber = String()
    var links = String()
    
    var pricing = String()
    var tourBio = String()
    var email = String()
    var gender = String()
    
    init(dictionary: [String: Any]) {
        
        guard let email = dictionary["email"] as? String,
            let gender = dictionary["gender"] as? String,
            let age = dictionary["age"] as? String,
            let name = dictionary["name"] as? String,
            let phoneNumber = dictionary["phone number"] as? String,
            let tourBio = dictionary["tour bio"] as? String
            else {
                fatalError("email is not found")
        }
        
        self.email = email
        self.gender = gender
        self.age = age
        self.name = name
        self.tourBio = tourBio
        self.phoneNumber = phoneNumber
        
    }
    
    func toDictionary() -> [String:Any] {
        return
            [ "email":self.email,
              "age":self.age,
              "name":self.name,
              "phone number":self.phoneNumber,
              "bio":self.bio,
              "tour bio":self.tourBio,
              "gender":self.gender,
              "location":self.location
        ]
    }
    
    init(snapshot: [String: Any]) {
        
        guard let name = snapshot["name"] as? String else{
            fatalError("name not found")
        }
        guard let email = snapshot["email"] as? String else{
            fatalError("email not found")
        }
        guard let phoneNumber = snapshot["phone number"] as? String else{
            fatalError("phone number not found")
        }
        guard let gender = snapshot["gender"] as? String else{
            fatalError("gender not found")
        }
        guard let age = snapshot["age"] as? String else{
            fatalError("age not found")
        }
        guard let bio = snapshot["bio"] as? String else{
            fatalError("bio not found")
        }
        guard let tourBio = snapshot["tour bio"] as? String else{
            fatalError("tour bio not found")
        }
        
        
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.gender = gender
        self.age = age
        self.bio = bio
        self.tourBio = tourBio
    }
    
    
    init() {
    }
    
    init(name: String, bio: String, age: String, location: String, email: String, gender: String, tourInfo: String){
        self.name = name
        self.bio = bio
        self.age = age
        self.location = location
        self.email = email
        self.gender = gender
        self.tourBio = tourInfo
    }
}


class City  {
    
    var cityTitle = String()
    var cityID = String()
    var imgURL = String()
    
    init(cityTitle: String, cityId: String, imgURL: String) {
        self.cityTitle = cityTitle
        self.cityID = cityId
        self.imgURL = imgURL
    }
    
    init(){
        
    }
}

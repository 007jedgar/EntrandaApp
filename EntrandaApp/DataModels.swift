//
//  DataModels.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/9/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import Foundation

class DataModels {
    
    var name = String()
    var location  = String()
    var tags = [String]()
    
    init(name: String, location: String) {
        
        self.name = name
        self.location = location
    }
    
    init() {
        
    }
}

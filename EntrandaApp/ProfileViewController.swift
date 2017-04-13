//
//  ProfileViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/11/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userProfileImgView: UIImageView!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sendMessageButton.layer.cornerRadius = self.sendMessageButton.frame.width / 7
        
        self.sendMessageButton.layer.shadowColor = UIColor.black.cgColor
        self.sendMessageButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.sendMessageButton.layer.shadowRadius = 5

    }

    @IBAction func sendMessageButtonPressed(_ sender: Any) {
        //Take data on page or object of user and send to the edit profile page
        performSegue(withIdentifier: "ToEditProfile", sender: nil)
        
    }
    
    

}

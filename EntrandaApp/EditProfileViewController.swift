//
//  EditProfileViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/11/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol PassUUIDDelegate {
    func sendData()
}

class EditProfileViewController: UITableViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var tagsField: UITextField!
    @IBOutlet weak var linkField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var profileImgView: UIImageView!
    
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello Edit ProfilePage")
    }
    
    @IBAction func SaveChangesButtonPressed(_ sender: Any) {
        
        guard let email = emailField.text else {
            print("no email")
            return
        }
        
        guard let name = nameField.text else {
            print("no name")
            return
        }
        
        guard let location = locationField.text else {
            print("no location")
            return
        }
        
        guard let link = linkField.text else {
            print("no link")
            return
        }
        
        guard let number = numberField.text else {
            print("no number")
            return
        }
        
        guard let bio = bioField.text else {
            print("no bio")
            return
        }
        
        guard let gender = genderField.text else {
            print("no gender")
            return
        }
        
        guard let tags = tagsField.text else {
            print("no tags")
            return
        }
        let uuid = UUID().uuidString
        
        let profileData = User(name: name, location: location, tags: tags, phoneNumber: number, email: email, bio: bio, gender: gender, link: link, userID: uuid)
        

        
        self.ref = FIRDatabase.database().reference()
        
        self.ref.child("User").child("fillerinfo")
        
        let key = ref.child("User")
        let user = key.child(profileData.userID)
        user.child("Name").setValue(profileData.name)
        user.child("email").setValue(profileData.email)
        user.child("bio").setValue(profileData.bio)
        user.child("gender").setValue(profileData.gender)
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        print("sent to DB")
    }

}

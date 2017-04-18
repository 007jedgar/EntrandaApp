//
//  CreateGuideTableViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/13/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateGuideTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref: FIRDatabaseReference!
    var imagePickerViewController : UIImagePickerController!

    
        @IBOutlet weak var nameTextField: UITextField!
        @IBOutlet weak var locationTextField: UITextField!
        @IBOutlet weak var ageTextField: UITextField!
        @IBOutlet weak var genderTextField: UITextField!
        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var tagsTextField: UITextField!
        @IBOutlet weak var phoneNumberTextField: UITextField!
        @IBOutlet weak var linksTextField: UITextField!
        @IBOutlet weak var quickBioTextField: UITextField!
        @IBOutlet weak var tourInfoTextField: UITextView!
        @IBOutlet weak var PricingTextField: UITextField!
        @IBOutlet weak var otherLinksTextField: UITextField!
        @IBOutlet weak var profileImgView: UIImageView!
        @IBOutlet weak var addPhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePickerViewController = UIImagePickerController()
        self.imagePickerViewController.delegate = self
        
        self.profileImgView.layer.cornerRadius = self.profileImgView.layer.frame.size.width / 7
        self.profileImgView.clipsToBounds = true
    }

    // MARK: - Table view data source

    //sends class to to firebase
    func sendGuideInfo(guideInfo: Guide) {
        
        self.ref = FIRDatabase.database().reference()
        
        self.ref.child("guide").child("fillerinfo")
        
        let key = ref.child("guide")
        let user = key.childByAutoId()
        user.child("name").setValue(guideInfo.name)
        let email = guideInfo.email
        user.child("email").setValue(email)
        let bio = guideInfo.bio
        user.child("bio").setValue(bio)
        let gender = guideInfo.gender
        user.child("gender").setValue(gender)
        let age = guideInfo.age
        user.child("age").setValue(age)
        let tourBio = guideInfo.tourBio
        user.child("tour bio").setValue(tourBio)
        let phoneNumber = guideInfo.phoneNumber
        user.child("phone number").setValue(phoneNumber)
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        print("sent to DB")
    }
    
    
    
    //Gets data from tableview and stores it in class
    @IBAction func getNewGuideInfo(_ sender: Any) {
        var message : String = "Check out your required fields"
        let notFinishedAlert = UIAlertController(title: "Empty Fields", message: "Almost: \(message)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            //
        }
        notFinishedAlert.addAction(okAction)

        guard let name = nameTextField.text, !name.isEmpty else {
            message = "check out the name field...what your friends call you"
            present(notFinishedAlert, animated: true, completion: nil)
            return
        }
        guard let age = ageTextField.text, !age.isEmpty else {
            message = "check out the age field...come on, be honest"
            present(notFinishedAlert, animated: true, completion: nil)
            return
        }
        guard let bio = quickBioTextField.text, !bio.isEmpty else {
            message = "check out the bio field...give us a cool fact, something funny, or what you like to do"
            present(notFinishedAlert, animated: true, completion: nil)
            return
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            message = "check out the email field...where your uncle sends you conspiracy theories"
            present(notFinishedAlert, animated: true, completion: nil)
            return
        }
        guard let location = locationTextField.text, !location.isEmpty else {
            message = "check out the location field...what side of town you're most familiar with"
            present(notFinishedAlert, animated: true, completion: nil)
            return
        }
        guard let gender = genderTextField.text, !gender.isEmpty else {
            message = "check out the gender field...social construct or not, you gotta supply us with something"
            present(notFinishedAlert, animated: true, completion: nil)
            return
        }
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            message = "check out the phone number field...what your ex thinks you changed"
            present(notFinishedAlert, animated: true, completion: nil)
            return
        }
        guard let tourInfo = tourInfoTextField.text, !tourInfo.isEmpty else {
            message = "check out the tour info field...what can we see durring the time we spend with you"
            present(notFinishedAlert, animated: true, completion: nil)
            return
        }
        
        let guide = Guide(name: name, bio: bio, age: age, location: location, email: email, gender: gender, tourInfo: tourInfo)
        guide.phoneNumber = phoneNumber
        
        sendGuideInfo(guideInfo: guide)
    }
    
    //Opens Alerts -> to camera gallery
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
            
            let addImageAlert = UIAlertController(title: "Guide Pic", message: "Select an Option", preferredStyle: .actionSheet)
            
            let fromGalleryOption = UIAlertAction(title: "Phone Library", style: .default) { (action: UIAlertAction) in
                
                self.imagePickerViewController.sourceType = .photoLibrary
                self.present(self.imagePickerViewController, animated: true, completion: nil)
            }
        
            let takePhotoOption = UIAlertAction(title: "Take Photo", style: .default) { (action: UIAlertAction) in
                
                self.imagePickerViewController.sourceType = .camera
                self.present(self.imagePickerViewController, animated: true, completion: nil)
            }
            
            let cancelOption = UIAlertAction(title: "Cancel", style:.cancel, handler:
                nil)
            
            addImageAlert.addAction(fromGalleryOption)
            addImageAlert.addAction(takePhotoOption)
            addImageAlert.addAction(cancelOption)
            self.present(addImageAlert, animated: true, completion: nil)
        }
    
    //For Camera Functionality
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //open camera
            //code...
            
        }else{
            
            print("camera isnt available")
        }
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let guide = Guide()
        guide.pictureURL = chosenImage
        self.profileImgView?.image = guide.pictureURL
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePickerViewController.dismiss(animated: true, completion: nil)
    }
    
}


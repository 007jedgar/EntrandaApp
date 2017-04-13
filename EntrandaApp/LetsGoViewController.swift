//
//  LetsGoViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/9/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage

protocol sendIDDelegate: class {
    func createSpecialUUID(name: String) -> [String: String]
}

class LetsGoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var tagPicker: UIPickerView!
    @IBOutlet weak var letsGoButton: UIButton!
    
    var profileDictionary = [String: String]()
    
    var selectedTag : String?
    var pickerData = [String]()
    
    weak var delegate: sendIDDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tagPicker.dataSource = self
        tagPicker.delegate = self
        // Do any additional setup after loading the view.

        
        textFields()
        populatePickerView()
        
        letsGoButton.layer.cornerRadius = self.letsGoButton.frame.size.width / 7

    }
    
    func annonymosLogin() {

    }

    //MARK: FOR PICKERVIEW
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedTag = pickerData[row]
        self.letsGoButton.setTitle(selectedTag, for: UIControlState.normal)

    }
    
    
    func textFields() {
    
        self.nameTextField.placeholder = "Name"
        self.locationTextField.placeholder = "Location"
        
    }
    
    func populatePickerView() {
        let tags = ["Fun", "Food", "Wine", "Music", "Atractions", "Exhibits", "Art", "Random","Fashion", "Gardens", "Beer", "Sports"]
        
        for tag in tags {
            self.pickerData.append(tag)

        }
    }
    
    //Allows User to start a sign in annonymosly
    @IBAction func letsGoButtonPressed(_ sender: Any) {
        if nameTextField?.text != "" {
            FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                
                self.performSegue(withIdentifier: "toGuidesSeque", sender: nil)
            })
        }
    }
    
    func createSpecialUUID(name: String) -> [String: String] {
        
        let uuid = UUID().uuidString
        let dictionary = [name: uuid]
        return dictionary
    }
    
}



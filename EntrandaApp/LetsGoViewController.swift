//
//  LetsGoViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/9/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit

class LetsGoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var tagPicker: UIPickerView!
    @IBOutlet weak var letsGoButton: UIButton!
    
    var selectedTag : String?
    var pickerData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tagPicker.dataSource = self
        tagPicker.delegate = self
        // Do any additional setup after loading the view.

        
        textFields()
        populatePickerView()
        
        letsGoButton.layer.cornerRadius = self.letsGoButton.frame.size.width / 7

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
        let tags = ["fun","Food", "Atractions", "Exhibits", "Art"]
        
        for tag in tags {
            self.pickerData.append(tag)

        }
    }
    
    @IBAction func letsGoButtonPressed(_ sender: Any) {
        
    }
}



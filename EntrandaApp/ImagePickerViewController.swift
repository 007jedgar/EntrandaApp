//
//  ImagePickerViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/14/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePickerViewController : UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePickerViewController = UIImagePickerController()
        self.imagePickerViewController.delegate = self
    }


    


}

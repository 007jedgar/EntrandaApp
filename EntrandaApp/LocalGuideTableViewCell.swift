//
//  LocalGuideTableViewCell.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/11/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit

class LocalGuideTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var startRatingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func starRating() {
        //For respected star ratings
        let user = User()
        
        switch(user.rating) {
        case 1 :
            self.startRatingLabel.text = "*"
        case 2 :
            self.startRatingLabel.text = "* *"
        case 3 :
            self.startRatingLabel.text = "* * *"
        case 4 :
            self.startRatingLabel.text = "* * * *"
        case 5:
            self.startRatingLabel.text = "* * * * *"
        default:
            self.startRatingLabel.text = "DERP"
        }
        
    }
    
}

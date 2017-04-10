//
//  LocalGuideCell.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/9/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit

class LocalGuideCell: UITableViewCell {
    
    @IBOutlet weak var profilePictureImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profilePictureImgView.layer.cornerRadius = self.profilePictureImgView.frame.size.width / 2
        self.profilePictureImgView.clipsToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

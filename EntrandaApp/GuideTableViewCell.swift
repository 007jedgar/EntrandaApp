//
//  GuideTableViewCell.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/13/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit

class GuideTableViewCell: UITableViewCell {

    @IBOutlet weak var guideProfileImgView: UIImageView!
    @IBOutlet weak var guideQuickBioLabel: UILabel!
    @IBOutlet weak var guideRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.guideProfileImgView.layer.cornerRadius = guideProfileImgView.layer.frame.size.width / 5
        self.guideProfileImgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

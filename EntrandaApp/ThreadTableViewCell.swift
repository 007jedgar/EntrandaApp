//
//  ThreadTableViewCell.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 5/9/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import Foundation
import UIKit

class ThreadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var lastMessgaeLablel: UILabel!
    @IBOutlet weak var dateSentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImgView.layer.cornerRadius = self.profileImgView.layer.frame.size.width / 7;
        self.profileImgView.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

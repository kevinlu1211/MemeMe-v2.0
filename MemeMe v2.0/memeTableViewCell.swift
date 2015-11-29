//
//  memeTableViewCell.swift
//  MemeMe v2.0
//
//  Created by Kevin Lu on 28/11/2015.
//  Copyright © 2015 Kevin Lu. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

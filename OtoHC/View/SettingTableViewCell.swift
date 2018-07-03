//
//  SettingTableViewCell.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 03/07/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var photoSet: UIImageView!
    @IBOutlet weak var labelSet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

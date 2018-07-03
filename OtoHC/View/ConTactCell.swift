//
//  ConTactCell.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 25/06/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit

class ConTactCell: UITableViewCell {

    @IBOutlet weak var photoMember: UIImageView!
    @IBOutlet weak var nameMember: UILabel!
    @IBOutlet weak var numberphoneMember: UILabel!
    @IBOutlet weak var adressMember: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

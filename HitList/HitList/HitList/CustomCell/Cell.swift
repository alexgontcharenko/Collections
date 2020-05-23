//
//  Cell.swift
//  HitList
//
//  Created by Steew on 16.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        surnameLabel.text = ""
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

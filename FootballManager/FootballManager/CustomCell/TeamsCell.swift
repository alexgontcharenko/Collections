//
//  TeamsCell.swift
//  FootballManager
//
//  Created by Steew on 04.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class TeamsCell: UITableViewCell {
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

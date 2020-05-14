//
//  DetailsCell.swift
//  TableViewCustom
//
//  Created by Steew on 13.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var firstTeamDetail: UILabel!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var secondTeamDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

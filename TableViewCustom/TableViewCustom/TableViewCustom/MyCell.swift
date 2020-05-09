//
//  MyCell.swift
//  TableViewCustom
//
//  Created by Steew on 09.05.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

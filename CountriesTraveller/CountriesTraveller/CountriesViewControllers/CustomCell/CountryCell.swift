//
//  CountryCell.swift
//  CountriesTraveller
//
//  Created by Steew on 21.06.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryRegionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

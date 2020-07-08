//
//  AztroCell.swift
//  Aztro
//
//  Created by Steew on 08.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import UIKit

class AztroCell: UICollectionViewCell {
    @IBOutlet weak var aztroImage: UIImageView!
    @IBOutlet weak var aztroLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aztroLabel.textColor = UIColor.white
    }
}

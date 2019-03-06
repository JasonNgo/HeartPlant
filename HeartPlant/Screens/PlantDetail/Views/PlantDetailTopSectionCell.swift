//
//  PlantDetailTopSectionCell.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-03-05.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class PlantDetailTopSectionCell: UITableViewCell {

    // MARK: - Subviews
    @IBOutlet weak var wateringTitleLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var wateringRuleLabel: UILabel!
    @IBOutlet weak var waterPlantButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        waterPlantButton.layer.cornerRadius = 8.0
    }

//    func configureCell(with viewModel: PlantDetailCellViewModel) {
//        
//    }
}

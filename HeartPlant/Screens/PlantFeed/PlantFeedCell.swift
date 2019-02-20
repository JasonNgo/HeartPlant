//
//  PlantFeedCell.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class PlantFeedCell: UICollectionViewCell {
    
    // MARK: - Subviews
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupSubViews() {
        contentView.addSubview(titleLabel)
        titleLabel.fillSuperview()
    }
    
    // MARK: - Configuration
    
    func configureCell(using viewModel: PlantFeedCellViewModel) {
        
    }
    
}


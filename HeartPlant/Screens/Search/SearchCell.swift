//
//  SearchCell.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    // MARK: - Subviews
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    
    // MARK: - Setup
    
    private func setupSubviews() {
        contentView.addSubview(nameLabel)
        nameLabel.fillSuperview()
    }
    
    // MARK: - Configuration
    
    func configureCell(using viewModel: SearchCellViewModel) {
        
    }
    
    // MARK: - Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

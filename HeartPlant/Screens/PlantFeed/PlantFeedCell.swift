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
    
    private let thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .red
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let scientificNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Scientific Name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = ColorManager.shared.primaryColor
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            scientificNameLabel,
            dateLabel
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    // MARK: - Setup
    
    private func setupSubViews() {
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 15, left: 16, bottom: 0, right: 0),
            size: .init(width: 70, height: 70)
        )
        
        contentView.addSubview(stackView)
        stackView.anchor(
            top: contentView.topAnchor,
            leading: thumbnailImageView.trailingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: 15, left: 12, bottom: 15, right: 8)
        )
        
        let dividerBottomView = UIView()
        dividerBottomView.backgroundColor = .lightGray
        contentView.addSubview(dividerBottomView)
        dividerBottomView.anchor(
            top: nil,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .zero,
            size: .init(width: 0, height: 0.5)
        )
    }
    
    // MARK: - Configuration
    
    func configureCell(using viewModel: PlantFeedCellViewModel) {
        nameLabel.text = viewModel.nameText
    }
    
    // MARK: - Required
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


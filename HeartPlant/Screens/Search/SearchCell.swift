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
    private let thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .blue
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
        label.text = "scientific name"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            nameLabel,
            scientificNameLabel
        ])
        
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fillEqually
        
        return sv
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    
    // MARK: - Setup
    
    private func setupSubviews() {
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
    
    func configureCell(using viewModel: SearchCellViewModel) {
        nameLabel.text = viewModel.nameText
        scientificNameLabel.text = viewModel.scientificNameText
    }
    
    // MARK: - Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

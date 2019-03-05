//
//  SearchViewController.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

private enum SearchState {
    case active
    case inactive
}

class SearchViewController: UIViewController, Deinitcallable {
    
    // MARK: - Views
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    // MARK: - Search
    
    private var searchState: SearchState = .inactive
    private let searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.dimsBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Search plants"
        return sc
    }()
    
    // MARK: - Styling Constants
    
    private let cellWidth = UIScreen.main.bounds.width
    private let cellHeight: CGFloat = 45
    private let minimumLineSpacingForSection: CGFloat = 1
    
    // MARK: - Initializers
    
    var onDeinit: (() -> Void)?
    
    deinit {
        onDeinit?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllerStyling()
        setupCollectionView()
        setupSearchController()
    }
    
    // MARK: - Setup
    
    private func setupControllerStyling() {
        title = "Search"
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.delegate = self
    }
    
    private func setupSearchController() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacingForSection
    }
}

extension SearchViewController: UISearchBarDelegate {
    
}

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

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController(_ searchViewController: SearchViewController, didSelectItem item: Plant)
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
    private let cellHeight: CGFloat = 100
    private let minimumLineSpacingForSection: CGFloat = 0
    
    // MARK: - Model
    private let dataSource: SearchDataSource
    
    // MARK: - Delegate
    weak var delegate: SearchViewControllerDelegate?
    
    // MARK: - Deinit
    var onDeinit: (() -> Void)?
    deinit {
        onDeinit?()
    }
    
    // MARK: - Initializer
    init(dataSource: SearchDataSource) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Life Cycle
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
        collectionView.dataSource = dataSource
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: dataSource.reuseId)
    }
    
    private func setupSearchController() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    // MARK: - Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.item(at: indexPath.item) else { return }
        delegate?.searchViewController(self, didSelectItem: item)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchState = .active
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchState = .inactive
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterCollectionResults(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterCollectionResults(with: "")
    }
    
    private func filterCollectionResults(with searchText: String) {
        dataSource.filterResults(with: searchText)
        collectionView.reloadData()
    }
}

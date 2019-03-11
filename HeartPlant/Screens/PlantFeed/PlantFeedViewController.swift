//
//  PlantFeedViewController.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-20.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

protocol PlantFeedViewControllerDelegate: AnyObject {
    func plantFeedViewController(_ plantFeedController: PlantFeedViewController, didSelectItem item: Plant)
}

class PlantFeedViewController: UIViewController, Deinitcallable {

    // MARK: - Views
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    // MARK: - Styling Constants
    private let cellWidth = UIScreen.main.bounds.width
    private let cellHeight: CGFloat = 100
    private let minimumLineSpacingForSection: CGFloat = 0
    
    // MARK: - Model
    private let dataSource: PlantFeedDataSource
    
    // MARK: - Notifications
    static let updateFavouritesNotificationName = NSNotification.Name(rawValue: "updateFavourites")
    
    // MARK: - Delegate
    weak var delegate: PlantFeedViewControllerDelegate?
    
    // MARK: - Deintcallable
    var onDeinit: (() -> Void)?
    deinit {
        onDeinit?()
    }
    
    // MARK: - Init
    init(dataSource: PlantFeedDataSource) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dataSource.fetchItems { [unowned self] error in
            if let _ = error {
                return
            }

            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllerStyling()
        setupCollectionView()
        setupGestureRecognizers()
        setupObservers()
        
        // TODO: Start activity spinner
        dataSource.fetchItems { [unowned self] error in
            // TODO: End activity spinner
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Setup
    private func setupControllerStyling() {
        title = "Plants"
        view.backgroundColor = .white
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.register(PlantFeedCell.self, forCellWithReuseIdentifier: dataSource.reuseId)
    }
    
    private func setupGestureRecognizers() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFavourites), name: PlantFeedViewController.updateFavouritesNotificationName, object: nil)
    }
    
    // MARK: - Gesture Selectors
    @objc private func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        
        guard let selectedIndexPath = collectionView.indexPathForItem(at: location) else {
            return
        }
        
        let alertController = UIAlertController(title: "Delete Plant",
                                                message: "Are you sure you'd like to delete this plant?",
                                                preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] (action) in
            do {
                try self.dataSource.remove(at: selectedIndexPath.item)
                self.collectionView.deleteItems(at: [selectedIndexPath])
            } catch let error as NSError {
                // TODO: Show error message
                print("There was an error attempting to delete: \(error)")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Notification Selectors
    @objc private func handleUpdateFavourites() {
        dataSource.fetchItems { [unowned self] error in
            if let _ = error {
                return
            }
            
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate
extension PlantFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacingForSection
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.item(at: indexPath.item) else {
            return
        }
        
        delegate?.plantFeedViewController(self, didSelectItem: item)
    }
}

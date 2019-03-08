//
//  PlantDetailViewController.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit
import CoreData

class PlantDetailViewController: UIViewController, Deinitcallable {
    
    // MARK: - Views
    private let topSectionIdentifier = "PlantDetailTopSectionCell"
    private let wateringInfoSectionIdentifier = "PlantDetailWateringInfoCell"
    private let characteristicsInfoSectionIdentifier = "PlantDetailCharacteristicsInfoCell"
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.backgroundColor = .white
        return tv
    }()
    
    // MARK: - Model
    private let plant: Plant
    private let coreDataStack: CoreDataStack
    
    // MARK: - Deinit
    var onDeinit: (() -> Void)?
    deinit {
        onDeinit?()
    }
    
    // MARK: - Initializers
    init(plant: Plant, coreDataStack: CoreDataStack) {
        self.plant = plant
        self.coreDataStack = coreDataStack
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        setupFavouriteButton()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - Setup
    private func setupViewController() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        let plantDetailTopSectionNib = UINib(nibName: "PlantDetailTopSectionCell", bundle: nil)
        let plantDetailWateringInfoSectionNib = UINib(nibName: "PlantDetailWateringInfoCell", bundle: nil)
        let plantDetailCharacteristicsInfoSectionNib = UINib(nibName: "PlantDetailCharacteristicsInfoCell", bundle: nil)
        
        tableView.register(plantDetailTopSectionNib, forCellReuseIdentifier: topSectionIdentifier)
        tableView.register(plantDetailWateringInfoSectionNib, forCellReuseIdentifier: wateringInfoSectionIdentifier)
        tableView.register(plantDetailCharacteristicsInfoSectionNib, forCellReuseIdentifier: characteristicsInfoSectionIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func setupFavouriteButton() {
        let favouriteButton = UIBarButtonItem(title: "Favourite", style: .plain, target: self, action: #selector(handleFavouritePressed))
        navigationItem.rightBarButtonItem = favouriteButton
    }
    
    @objc func handleFavouritePressed() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Plant")
        fetchRequest.predicate = NSPredicate(format: "name = %@", plant.name ?? "")
        do {
            let results = try coreDataStack.managedContext.fetch(fetchRequest)
            let resultsData = results as! [Plant]
            let object = resultsData[0]
            
            plant.isFavourited.toggle()
            object.setValue(plant.isFavourited, forKey: "isFavourited")
            try coreDataStack.managedContext.save()
        } catch let error as NSError {
            print("Unresolved error: \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Required
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PlantDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: topSectionIdentifier, for: indexPath) as! PlantDetailTopSectionCell
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: wateringInfoSectionIdentifier, for: indexPath) as! PlantDetailWateringInfoCell
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: characteristicsInfoSectionIdentifier, for: indexPath) as! PlantDetailCharacteristicsInfoCell
            return cell
        }
        
        return UITableViewCell()
    }
}

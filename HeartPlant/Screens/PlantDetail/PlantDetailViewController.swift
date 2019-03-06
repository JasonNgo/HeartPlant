//
//  PlantDetailViewController.swift
//  HeartPlant
//
//  Created by Jason Ngo on 2019-02-21.
//  Copyright © 2019 Jason Ngo. All rights reserved.
//

import UIKit

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
    
    // MARK: - Deinit
    var onDeinit: (() -> Void)?
    deinit {
        onDeinit?()
    }
    
    // MARK: - Initializers
    init(plant: Plant) {
        self.plant = plant
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - Setup
    private func setupViewController() {
        view.backgroundColor = .white
//        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationController?.navigationItem.largeTitleDisplayMode = .never
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

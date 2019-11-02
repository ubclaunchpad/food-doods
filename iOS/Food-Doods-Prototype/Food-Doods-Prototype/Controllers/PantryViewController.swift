//
//  FirstViewController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-14.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class PantryViewController: UIViewController {
    var tableView: UITableView!
    var allItemArray: [Item] = []
    var itemArray: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = PantryView();
        tableView = newView.tableView
        newView.segmentControl.selectedSegmentIndex = 0
        newView.segmentControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        self.view = newView
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pantry"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PantryTableViewCell.self, forCellReuseIdentifier: "PantryCell")
        tableView.separatorStyle = .none
        
        allItemArray.append(Item(name: "Carrot", image: UIImage(named: "carrot"), location: FoodLocation.fridge, amount: 300))
        allItemArray.append(Item(name: "Beef", image: UIImage(named: "steak"), location: FoodLocation.fridge, amount: 300))
        allItemArray.append(Item(name: "Spaghetti", image: UIImage(named: "spaghetti"), location: FoodLocation.pantry, amount: 300))
        itemArray = allItemArray
    }
    
    
    
    @objc
    private func segmentSelected(sender: UISegmentedControl) {
        var foodSection: FoodLocation?
        switch(sender.selectedSegmentIndex) {
        case 0: foodSection = .all
        case 1: foodSection = .pantry
        case 2: foodSection = .fridge
        case 3: foodSection = .dry
        default:
            print("Fatal error")
        }
        itemArray = []
        for item in allItemArray {
            if item.location == foodSection || foodSection == .all {
                itemArray.append(item)
            }
        }
        self.tableView.reloadData()
    }

}



extension PantryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PantryCell", for: indexPath)
        
        guard let pantryCell = cell as? PantryTableViewCell else {
            return cell
        }

        let item = itemArray[indexPath.row]
        pantryCell.mainText.text = item.name
        pantryCell.foodImage.image = item.image
        return pantryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushVC = ItemViewController()
        pushVC.item = itemArray[indexPath.row]
        
        navigationController?.pushViewController(pushVC, animated: true)
    }
    
}

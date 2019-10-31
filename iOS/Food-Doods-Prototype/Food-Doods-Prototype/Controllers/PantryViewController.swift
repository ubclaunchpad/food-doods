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
    var itemArray: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = PantryView();
        tableView = newView.tableView
        self.view = newView
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pantry"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PantryTableViewCell.self, forCellReuseIdentifier: "PantryCell")
        tableView.separatorStyle = .none
        
        itemArray.append(Item(name: "Carrot", image: UIImage(named: "carrot"), location: FoodLocation.fridge))
        itemArray.append(Item(name: "Beef", image: UIImage(named: "steak"), location: FoodLocation.fridge))
        itemArray.append(Item(name: "Spaghetti", image: UIImage(named: "spaghetti"), location: FoodLocation.pantry))
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
        navigationController?.pushViewController(ItemViewController(), animated: true)
    }
    
}

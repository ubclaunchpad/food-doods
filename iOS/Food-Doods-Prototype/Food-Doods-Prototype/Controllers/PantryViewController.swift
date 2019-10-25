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
        
    }

}



extension PantryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PantryCell", for: indexPath)
        
        guard let pantryCell = cell as? PantryTableViewCell else {
            return cell
        }
        pantryCell.mainText.text = "THIS IS CARROT NUMBER \(indexPath.row+1)"
        pantryCell.foodImage.image = UIImage(named: "carrot")
        return pantryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ItemViewController(), animated: true)
    }
    
}

//
//  ShoppingListViewController.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-11-02.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = ShoppingListView()
        tableView = newView.tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "ShoppingCell")
        tableView.separatorStyle = .none
        
        
        self.view = newView
        
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Shopping List"
    }
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath)
        
        //TODO: Change!
        guard let shoppingCell = cell as? PantryTableViewCell else {
            return cell
        }

        return shoppingCell
    }
    
    
}

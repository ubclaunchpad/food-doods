//
//  ShoppingListViewController.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-11-02.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit


var shoppingListItems: [ShoppingItem] =
    [
        ShoppingItem(name: "Carrots", image: UIImage(named: "carrot"), price: 7.99, amount: 500, selected: false),
        ShoppingItem(name: "Cheese", image: UIImage(named: "cheese"), price: 5.99, amount: 75, selected: false),
        ShoppingItem(name: "Steak", image: UIImage(named: "steak"), price: 29.99, amount: 450, selected: false),
        ShoppingItem(name: "Broccoli", image: UIImage(named: "broccoli"), price: 4.99, amount: 300, selected: false),
        ShoppingItem(name: "Granola Bars", image: UIImage(named: "granola-bars"), price: 12.95, amount: 1300, selected: false)
    ]

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
        tableView.allowsSelectionDuringEditing = false
        tableView.allowsMultipleSelectionDuringEditing = false

        
        self.view = newView
        
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Shopping List"
    }
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66 + 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath)
        
        //TODO: Change!
        guard let shoppingCell = cell as? ShoppingListTableViewCell else {
            return cell
        }
        
        shoppingCell.foodImage.image = shoppingListItems[indexPath.row].image
        shoppingCell.nameLabel.text = shoppingListItems[indexPath.row].name
        shoppingCell.amountLabel.text = "\(shoppingListItems[indexPath.row].amount) g"
        
        if shoppingListItems[indexPath.row].selected {
            shoppingCell.selectedIcon.image = UIImage(systemName: "checkmark.square")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        } else {
            shoppingCell.selectedIcon.image = UIImage(systemName: "square")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }

        return shoppingCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if shoppingListItems[indexPath.row].selected {
            shoppingListItems[indexPath.row].selected = false
        } else {
            shoppingListItems[indexPath.row].selected = true
        }
        
        tableView.reloadData()
    }
    
    
}

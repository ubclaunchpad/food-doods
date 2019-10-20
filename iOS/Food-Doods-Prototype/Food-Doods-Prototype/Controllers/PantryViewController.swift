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
        var newView = PantryView();
        tableView = newView.tableView
        self.view = newView
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pantry"
        
    }

}



extension PantryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}

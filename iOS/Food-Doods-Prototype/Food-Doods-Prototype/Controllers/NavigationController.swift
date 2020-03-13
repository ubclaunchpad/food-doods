//
//  TestTableViewController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-15.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    var model: Recipe!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

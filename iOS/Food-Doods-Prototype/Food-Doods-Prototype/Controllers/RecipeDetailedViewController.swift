//
//  RecipeDetailedViewController.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2020-02-08.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import UIKit

class RecipeDetailedViewController: UIViewController {
    var model: Recipe!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = model.name
        self.view.backgroundColor = .white
    }
}

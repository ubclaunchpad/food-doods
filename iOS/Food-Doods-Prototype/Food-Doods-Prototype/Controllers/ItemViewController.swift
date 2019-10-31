//
//  ItemViewController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-25.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemView = ItemView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Detailed Item View"
        self.view = itemView
    }
    
}

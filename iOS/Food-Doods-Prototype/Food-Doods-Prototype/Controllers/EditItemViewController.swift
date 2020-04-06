//
//  EditItemViewController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-11-09.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController {
    var item: Item?
    var itemIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemView = EditItemView()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = item?.name
        
        itemView.viewModel = item
        self.view = itemView
    }
    
   
    
    
}

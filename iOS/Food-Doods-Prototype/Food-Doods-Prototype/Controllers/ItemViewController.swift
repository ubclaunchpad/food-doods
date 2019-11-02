//
//  ItemViewController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-25.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemView = ItemView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = item?.name
        itemView.itemIcon.image = item?.image
        
        if let amount = item?.amount {
            itemView.itemQuantity.text = "Quantity: "  + "\(amount)g"
        }
        
        self.view = itemView
    }
    
}

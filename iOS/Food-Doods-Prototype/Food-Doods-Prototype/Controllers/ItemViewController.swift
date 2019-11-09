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
        navigationItem.title = "Item View"
        itemView.itemIcon.image = item?.image
        
        itemView.itemName.text = item?.name
        
        if let amount = item?.amount {
            itemView.itemQuantity.text = "\(amount)g"
        }
        
        if let expiry = item?.expiresIn {
            itemView.expiryDate.text = "\(expiry) days"
        }
        

        
        self.view = itemView
    }
    
}

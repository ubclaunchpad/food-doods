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
        navigationItem.title = "Edit Item"
        
        itemView.itemIcon.image = item?.image
        itemView.itemName.text = item?.name
        itemView.itemIndex = self.itemIndex
        
        if let amount = item?.amount {
            itemView.itemQuantity.text = "\(amount)g"
        }
  
        if let expiry = item?.expiresIn {
            itemView.expiryDate.text = "\(expiry) days"
        }
        
        
        
        self.view = itemView
    }
    
   
    
    
}

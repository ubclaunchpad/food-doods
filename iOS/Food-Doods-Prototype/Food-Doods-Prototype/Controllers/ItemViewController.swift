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
    var itemIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemView = ItemView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Item View"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed(sender:)))
         itemView.itemIcon.image = item?.image
        
        itemView.itemName.text = item?.name
        
        if let amount = item?.amount {
            itemView.itemQuantity.text = "\(amount) g"
        }
        
        if let expiry = item?.expiresIn {
            itemView.expiryDate.text = "\(expiry) days"
        }
        
        self.view = itemView
    }
    
    @objc
    private func editButtonPressed(sender: UIBarButtonItem) {
        let pushVC = EditItemViewController()
        pushVC.item = self.item
        pushVC.itemIndex = self.itemIndex
        
        //can turn off animation to "pretend" we're on the same view, but different
        //bottom half of screen
        //OR, we can just do a proper segue to the new VC and have a new UI
        navigationController?.pushViewController(pushVC, animated: false)
    }
    
}

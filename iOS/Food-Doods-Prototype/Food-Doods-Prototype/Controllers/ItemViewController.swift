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
        navigationItem.title = item?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed(sender:)))
        itemView.viewModel = item
        
        self.view = itemView
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(editButtonPressed))
        }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            
            // Make the navigation bar background clear
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
        }
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            // Restore the navigation bar to default
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
        }
    
    @objc
    private func editButtonPressed(sender: UIBarButtonItem) {

    }
    
}

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
    var favourited = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = RecipeDetailedView()
        newView.viewModel = model
        
        self.view = newView
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleHeartTap))
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
        navigationController?.navigationBar.backgroundColor = UIColor(named: "menuColor")
        navigationController?.navigationBar.shadowImage = nil
    }
    
    
    @objc func handleHeartTap() {
        if(!favourited) {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            #warning("Set favourite to update the real model")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        }
        favourited = !favourited
    }
}

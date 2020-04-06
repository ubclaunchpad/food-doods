//
//  RecipeDetailedViewController.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2020-02-08.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import UIKit

class RecipeDetailedViewController: UIViewController, CustomSegmentedControlDelegate {
    var model: RecipeModel!
    var favourited = false
    var newView: RecipeDetailedView!
    var favouriteDelegate: FavouritedDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        newView = RecipeDetailedView()
        newView.viewModel = model
        newView.bottomView.selectionSegmentedControl.delegate = self
        self.view = newView
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: favourited ? UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) : UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(handleHeartTap))
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
    
    func changeToIndex(index: Int) {
        print("changing index")
        if(index == 0) {
            newView.segmentedValue = .instructions
        } else if (index == 1) {
            newView.segmentedValue = .preperation
        } else {
            newView.segmentedValue = .reviews
        }
    }
    @objc func handleHeartTap() {
        if(!favourited) {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            #warning("Set favourite to update the real model")
            favouriteDelegate.addFavourite(recipe: model)
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal)
            favouriteDelegate.removeFavourite(recipe: model)
        }
        favourited = !favourited
    }
}

protocol FavouritedDelegate {
    func addFavourite(recipe: RecipeModel)
    func removeFavourite(recipe: RecipeModel)
}

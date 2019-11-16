//
//  RecipesViewController.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-11-02.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit


class RecipesViewController: UIViewController {
    var allRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = RecipeView()
        newView.collectionView.delegate = self
        newView.collectionView.dataSource = self
        newView.collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view = newView
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Recipes"
    }
}


extension RecipesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.height/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let collectionCell = cell as? RecipeCollectionViewCell else {
            return cell
        }
        collectionCell.recipeImage.image = UIImage(named: "carrot")
        
        return collectionCell
    }
    
    
}

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
        
        setupMockData()
    }
    func setupMockData()  {
        var mockIngredients: [Item] = []
        var ingredOwned: [Item] = []
        for _ in 0...15 {
            mockIngredients.append(Item(name: "", image: UIImage(named: "carrot"), location: .all, amount: 1, expires: 1, shelfLife: 1))
        }
        for _ in 0...4 {
            ingredOwned.append(Item(name: "", image: UIImage(named: "carrot"), location: .all, amount: 1, expires: 1, shelfLife: 1))
        }
        
        var recipe = Recipe(name: "Canadian Poutine", image: UIImage(named: "poutine"), ingredientsNeeded: mockIngredients, ingredientsOwned: ingredOwned, time: 30, difficulty: "Medium")
        allRecipes.append(recipe)
        
        ingredOwned.remove(at: 0)
        recipe = Recipe(name: "Chinese Beef Noodles", image: UIImage(named: "beefnoodles"), ingredientsNeeded: ingredOwned, ingredientsOwned: ingredOwned, time: 35, difficulty: "Medium")
        allRecipes.append(recipe)
        
        recipe = Recipe(name: "Carbonara", image: UIImage(named: "carbonara"), ingredientsNeeded: ingredOwned, ingredientsOwned: ingredOwned, time: 20, difficulty: "Easy")
        allRecipes.append(recipe)
        
        mockIngredients.remove(at: 0)
        recipe = Recipe(name: "French Pepper Steak", image: UIImage(named: "frenchpepper"), ingredientsNeeded: mockIngredients, ingredientsOwned: ingredOwned, time: 15, difficulty: "Easy")
        allRecipes.append(recipe)
        
        recipe = Recipe(name: "Maple Salmon", image: UIImage(named: "maplesalmon"), ingredientsNeeded: mockIngredients, ingredientsOwned: ingredOwned, time: 40, difficulty: "Medium")
        allRecipes.append(recipe)
        
        recipe = Recipe(name: "Risotto", image: UIImage(named: "risotto"), ingredientsNeeded: mockIngredients, ingredientsOwned: ingredOwned, time: 50, difficulty: "Hard")
        allRecipes.append(recipe)
        
    }
}


extension RecipesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.08, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let collectionCell = cell as? RecipeCollectionViewCell else {
            return cell
        }
        collectionCell.nameLabel.text = allRecipes[indexPath.item].name
        collectionCell.recipeImage.image = allRecipes[indexPath.item].image
        collectionCell.timeLabel.text = "\(Int(allRecipes[indexPath.item].time)) minutes"
        collectionCell.ingredientLabel.text = "\(allRecipes[indexPath.item].ingredientsOwned.count)/\(allRecipes[indexPath.item].ingredientsNeeded.count) ingredients"
        collectionCell.difficultyLabel.text = allRecipes[indexPath.item].difficulty
        
        return collectionCell
    }
    
    
}

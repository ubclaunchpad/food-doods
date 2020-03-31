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
    var serverRecipes: [RecipeModel] = []
    
    var newView: RecipeView!
    
    // MARK: - Testing
    let testIDs =
        [
            "5e7ecf3bd7ab9fa3fec1e045",
            "5e7ecfedd7ab9fa3fec1e04b",
            "5e7ed024d7ab9fa3fec1e051",
            "5e7ed01cd7ab9fa3fec1e050",
            "5e7ed075d7ab9fa3fec1e054"
        ]
    
    var successCounter: Int = 0 {
        didSet {
            if successCounter == testIDs.count {
                print("Ready!")
                newView.collectionView.reloadData()
                //MARK: DO WORK HERE TO LOAD DATA INTO VIEW
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newView = RecipeView()
        newView.collectionView.delegate = self
        newView.collectionView.dataSource = self
        newView.collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view = newView
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(openFilter))
        navigationController?.navigationBar.backgroundColor = UIColor(named: "menuColor")
        navigationItem.title = "Recipes"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        
        // setupMockData()
        getRecipeData()
    }
    
    func getRecipeData() {
        
        for id in testIDs {
            RecipeAPIUtil.shared.getRecipeBy(recipeID: id, completionHandler: apiCompletionHandler)
        }
        
        // MARK: Debug
        let _ = Timer.scheduledTimer(withTimeInterval: TimeInterval(2), repeats: false, block: {_ in 
            print(self.serverRecipes)
        })
    }
    
    lazy var apiCompletionHandler: (RecipeModel) -> Void = {
        recipe in
        print("Got here!")
        self.serverRecipes.append(recipe)
        self.successCounter += 1
    }
    
    @objc func openFilter() {
        //MARK: TODO
        let newVC =  FilterViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }
//    func setupMockData()  {
//        var mockIngredients: [Item] = []
//        var ingredOwned: [Item] = []
//        for _ in 0...15 {
//            mockIngredients.append(Item(name: "Carrot", image: UIImage(named: "carrot"), location: .all, amount: 1, expires: 1, shelfLife: 1))
//        }
//        for _ in 0...4 {
//            ingredOwned.append(Item(name: "Carrot Owned Edition", image: UIImage(named: "carrot"), location: .all, amount: 1, expires: 1, shelfLife: 1))
//        }
//
//        var recipe = Recipe(name: "Canadian Poutine", image: UIImage(named: "poutine"), ingredientsNeeded: mockIngredients, ingredientsOwned: ingredOwned, time: 30, difficulty: "Medium")
//        allRecipes.append(recipe)
//
//        ingredOwned.remove(at: 0)
//        recipe = Recipe(name: "Chinese Beef Noodles", image: UIImage(named: "beefnoodles"), ingredientsNeeded: ingredOwned, ingredientsOwned: ingredOwned, time: 35, difficulty: "Medium")
//        allRecipes.append(recipe)
//
//        recipe = Recipe(name: "Carbonara", image: UIImage(named: "carbonara"), ingredientsNeeded: ingredOwned, ingredientsOwned: ingredOwned, time: 20, difficulty: "Easy")
//        allRecipes.append(recipe)
//
//        mockIngredients.remove(at: 0)
//        recipe = Recipe(name: "French Pepper Steak", image: UIImage(named: "frenchpepper"), ingredientsNeeded: mockIngredients, ingredientsOwned: ingredOwned, time: 15, difficulty: "Easy")
//        allRecipes.append(recipe)
//
//        recipe = Recipe(name: "Maple Salmon", image: UIImage(named: "maplesalmon"), ingredientsNeeded: mockIngredients, ingredientsOwned: ingredOwned, time: 40, difficulty: "Medium")
//        allRecipes.append(recipe)
//
//        recipe = Recipe(name: "Risotto", image: UIImage(named: "risotto"), ingredientsNeeded: mockIngredients, ingredientsOwned: ingredOwned, time: 50, difficulty: "Hard")
//        allRecipes.append(recipe)
//
//    }
}


extension RecipesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 304)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serverRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let collectionCell = cell as? RecipeCollectionViewCell else {
            return cell
        }
        collectionCell.nameLabel.text = serverRecipes[indexPath.item].recipe.name
        
        #warning("Change picture")
        collectionCell.recipeImage.image = UIImage(named: "beefnoodles")
        
        let cookTime = serverRecipes[indexPath.item].recipe.time.cook
        collectionCell.timeLabel.text = "\(cookTime) minutes"
        
        collectionCell.ingredientLabel.text = "Temp"
        collectionCell.difficultyLabel.text = "\(serverRecipes[indexPath.item].recipe.servings) servings"
        
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newVC = RecipeDetailedViewController()
        
        newVC.model = serverRecipes[indexPath.item]
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    
}

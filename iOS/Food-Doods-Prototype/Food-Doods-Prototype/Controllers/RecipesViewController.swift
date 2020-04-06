//
//  RecipesViewController.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-11-02.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit


class RecipesViewController: UIViewController, CustomSegmentedControlDelegate, FavouritedDelegate {
    
    var allRecipes: [Recipe] = []
    var serverRecipes: [RecipeModel] = []
    var favouriteRecipes: [RecipeModel] = []
    var searchRecipes: [RecipeModel] = []
    var newView: RecipeView!
    
    // MARK: - Testing
    var suggestionIDs: [String] = [] {
        didSet {
            fetchRecipes()
        }
    }
    
    var successCounter: Int = 0 {
        didSet {
            if successCounter == suggestionIDs.count {
                print("Ready!")
                newView.collectionView.reloadData()
                //MARK: DO WORK HERE TO LOAD DATA INTO VIEW
            }
        }
    }
    
    private var recipeFilter: SegmentedChoice = .suggested
    var collectionView: UICollectionView!
    var textField: UITextField!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newView = RecipeView()
        collectionView = newView.collectionView
        newView.collectionView.delegate = self
        newView.collectionView.dataSource = self
        newView.collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        newView.segmentControl.delegate = self
        textField = newView.searchBar.searchField
        textField.delegate = self
        
        self.view = newView
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(openFilter))
        navigationController?.navigationBar.backgroundColor = UIColor(named: "menuColor")
        navigationItem.title = "Recipes"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        
        // setupMockData()
        getSuggestions()
    }
    
    func getSuggestions() {
        SuggestionAPIUtil.shared.suggestRecipesBy(userID: "5e8a72243b4ffe3a0afb5f26", completion: suggestionCompletion)
    }
    
    func fetchRecipes() {
        for id in suggestionIDs {
            RecipeAPIUtil.shared.getRecipeBy(recipeID: id, completionHandler: recipeCompletion)
        }
    }
    
    lazy var suggestionCompletion: (SuggestionModel?) -> Void = {
        suggestion in
        
        if let suggestion = suggestion {
            self.suggestionIDs = suggestion.recipes
            print("Suggested Recipe IDs: \(suggestion.recipes)")
        }
    }
    
    lazy var recipeCompletion: (RecipeModel) -> Void = {
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
    
    func changeToIndex(index: Int) {
        if(recipeFilter == .search) {
            guard var text = textField.text else {
                return
            }
            if(index == 1) {
                searchRecipes = favouriteRecipes.filter({ $0.recipe.name.lowercased().contains(text.lowercased())})
            } else {
                searchRecipes = serverRecipes.filter({ $0.recipe.name.lowercased().contains(text.lowercased())})
            }
        } else {
            recipeFilter = (index == 1) ? .favourites : .suggested
        }
        collectionView.reloadData()
    }
    func addFavourite(recipe: RecipeModel) {
        favouriteRecipes.append(recipe)
    }
    
    func removeFavourite(recipe: RecipeModel) {
        favouriteRecipes.removeAll { $0.recipe.id == recipe.recipe.id }
    }
    enum SegmentedChoice {
        case favourites
        case suggested
        case search
    }
}


extension RecipesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 304)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (recipeFilter == .favourites) {
            return favouriteRecipes.count
        } else if (recipeFilter == .suggested){
            return serverRecipes.count
        }
        return searchRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let collectionCell = cell as? RecipeCollectionViewCell else {
            return cell
        }
        
        var filterArr = serverRecipes
        if(recipeFilter == .search) {
            filterArr = searchRecipes
        }
        if(recipeFilter == .favourites) {
            filterArr = favouriteRecipes
        }
        
        if(favouriteRecipes.contains(where: {$0.recipe.id == filterArr[indexPath.item].recipe.id})) {
            collectionCell.heartImage.image = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        } else {
            collectionCell.heartImage.image = nil
        }
        
        collectionCell.nameLabel.text = filterArr[indexPath.item].recipe.name
        
        #warning("Change picture")
        collectionCell.recipeImage.image = UIImage(named: "beefnoodles")
        
        let timeToCook = filterArr[indexPath.item].recipe.time.cook
        let arr = timeToCook.split(separator: " ")
        var finalString = timeToCook
        if(arr.last == "m") {
            finalString = "\(arr.first ?? "0") minutes"
        } else if(arr.last == "h") {
            finalString = "\(arr.first ?? "0") hours"
        }
        (collectionCell.stackView.arrangedSubviews[0] as! RecipeImageTextView).label.text = finalString
        (collectionCell.stackView.arrangedSubviews[1] as! RecipeImageTextView).label.text = "\(filterArr[indexPath.item].recipe.servings) servings"
        (collectionCell.stackView.arrangedSubviews[2] as! RecipeImageTextView).label.text = "2 people"
        
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newVC = RecipeDetailedViewController()
        newVC.favouriteDelegate = self
        var filterArr = serverRecipes
        if(recipeFilter == .search) {
            filterArr = searchRecipes
        }
        if(recipeFilter == .favourites) {
            filterArr = favouriteRecipes
        }
        if(favouriteRecipes.contains(where: {$0.recipe.id == filterArr[indexPath.item].recipe.id})) {
            newVC.favourited = true
            newVC.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        }
        newVC.model = filterArr[indexPath.item]
        navigationController?.pushViewController(newVC, animated: true)
    }
}

extension RecipesViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField.text?.count == 1 && string == "") {
            print("done editing")
            recipeFilter = (newView.segmentControl.selectedIndex == 1) ? .favourites : .suggested
            collectionView.reloadData()
            return true
        } else {
            guard var text = textField.text else {
                return true
            }
            if(string == "") {
                text.removeLast()
            } else {
                text.append(string)
            }
            if(newView.segmentControl.selectedIndex == 1) {
                searchRecipes = favouriteRecipes.filter({ $0.recipe.name.lowercased().contains(text.lowercased())})
            } else {
                searchRecipes = serverRecipes.filter({ $0.recipe.name.lowercased().contains(text.lowercased())})
            }
            recipeFilter = .search
            collectionView.reloadData()
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

//
//  TestViewController.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2020-02-29.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        //MARK: Test Button 1
        var getRecipesButton = UIButton()
        getRecipesButton.translatesAutoresizingMaskIntoConstraints = false
        getRecipesButton.layer.cornerRadius = 10
        getRecipesButton.backgroundColor = .blue
        getRecipesButton.setTitle("Get Recipes", for: .normal)
        
        //MARK: Test Button 2
        var freeButton = UIButton()
        freeButton.translatesAutoresizingMaskIntoConstraints = false
        freeButton.layer.cornerRadius = 10
        freeButton.backgroundColor = .cyan
        freeButton.setTitle("Get Recipe By ID", for: .normal)
        
        //MARK: Test Button 3
        var getIngredientsButton = UIButton()
        getIngredientsButton.translatesAutoresizingMaskIntoConstraints = false
        getIngredientsButton.layer.cornerRadius = 10
        getIngredientsButton.backgroundColor = .red
        getIngredientsButton.setTitle("Get Ingredients", for: .normal)
        
        //MARK: Test Button 4
        var createUserButton = UIButton()
        createUserButton.translatesAutoresizingMaskIntoConstraints = false
        createUserButton.layer.cornerRadius = 10
        createUserButton.backgroundColor = .purple
        createUserButton.setTitle("Create User", for: .normal)
        
        //MARK: Test Button 5
        var openLoginViewButton = UIButton()
        openLoginViewButton.translatesAutoresizingMaskIntoConstraints = false
        openLoginViewButton.layer.cornerRadius = 10
        openLoginViewButton.backgroundColor = .orange
        openLoginViewButton.setTitle("Pop Login View", for: .normal)
        
        //MARK: Test Button 6
        var postUserIngredientsButton = UIButton()
        postUserIngredientsButton.translatesAutoresizingMaskIntoConstraints = false
        postUserIngredientsButton.layer.cornerRadius = 10
        postUserIngredientsButton.backgroundColor = .green
        postUserIngredientsButton.setTitle("Post Ingredient User", for: .normal)
        
        self.view.addSubview(getRecipesButton)
        self.view.addSubview(freeButton)
        self.view.addSubview(getIngredientsButton)
        self.view.addSubview(createUserButton)
        self.view.addSubview(openLoginViewButton)
        self.view.addSubview(postUserIngredientsButton)

        
        //MARK: Test Button 1 Constraints
        getRecipesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getRecipesButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        getRecipesButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        getRecipesButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        getRecipesButton.addTarget(self, action: #selector(getRecipes), for: .touchUpInside)
        
        //MARK: Test Button 2 Constraints
        freeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        freeButton.topAnchor.constraint(equalTo: getRecipesButton.bottomAnchor, constant: 10).isActive = true
        freeButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        freeButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        freeButton.addTarget(self, action: #selector(getRecipeByID), for: .touchUpInside)
        
        //MARK: Test Button 3 Constraints
        getIngredientsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getIngredientsButton.topAnchor.constraint(equalTo: freeButton.bottomAnchor, constant: 10).isActive = true
        getIngredientsButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        getIngredientsButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        getIngredientsButton.addTarget(self, action: #selector(getIngredientsAction), for: .touchUpInside)
        
        //MARK: Test Button 4 Constraints
        createUserButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        createUserButton.topAnchor.constraint(equalTo: getIngredientsButton.bottomAnchor, constant: 10).isActive = true
        createUserButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        createUserButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        createUserButton.addTarget(self, action: #selector(createUserAction), for: .touchUpInside)
        
        //MARK: Open Login View Button Constraints
        openLoginViewButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        openLoginViewButton.topAnchor.constraint(equalTo: createUserButton.bottomAnchor, constant: 10).isActive = true
        openLoginViewButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        openLoginViewButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        openLoginViewButton.addTarget(self, action: #selector(openLoginView), for: .touchUpInside)
        
        //MARK: Post Ingredients User Constraints
        postUserIngredientsButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        postUserIngredientsButton.topAnchor.constraint(equalTo: freeButton.bottomAnchor, constant: 10).isActive = true
        postUserIngredientsButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        postUserIngredientsButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        postUserIngredientsButton.addTarget(self, action: #selector(getIngredientUser), for: .touchUpInside)
    }
    
    @objc func getRecipes() {
        print("Calling Recieps Endpoint")
        LocalHostTest.shared.getRecipeSuggestions()
    }
    @objc func getIngredientUser() {
        print("Calling Get User for Ingredients Enpoint: POST USER")
        LocalHostTest.shared.postIngredientUser()
    }
    @objc func getIngredientsAction() {
        // IngredientAPIUtil.shared.getUserIngredientList(userID: "11")
    }
    
    @objc func createUserAction() {
        print("Calling User Endpoint: POST CREATE")
        
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImVhdEhlYWx0aHkiLCJpYXQiOjE1ODYxMzE0OTM3NDYsImV4cCI6MTU4NjEzMjA5ODU0Nn0.Fze36YFphsx-c91_luK1_ybJxxr6c_KoCbXq-yr7kTM"
        
        let email = "foodDoods@gmail.com"
        let username = "eatHealthy"
        let password = "swiftyboi"
        let fullName = "Food Doods"
        UserAPIUtil.shared.createNewUser(email: email, username: username, password: password, fullName: fullName)
    }
    
    @objc func openLoginView() {
        print("Opening Login View")
        let presentVC = LoginViewController()
        present(presentVC, animated: true, completion: nil)
    }
    
    
    @objc func getRecipeByID() {
        print("Getting recipe by ID")
        let id = "5e7ecf6bd7ab9fa3fec1e048"
        RecipeAPIUtil.shared.getRecipeBy(recipeID: id, completionHandler: {_ in 
            return
        })
    }
}


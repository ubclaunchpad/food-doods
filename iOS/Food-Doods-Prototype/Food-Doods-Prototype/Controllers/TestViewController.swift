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
        var loginUserButton = UIButton()
        loginUserButton.translatesAutoresizingMaskIntoConstraints = false
        loginUserButton.layer.cornerRadius = 10
        loginUserButton.backgroundColor = .cyan
        loginUserButton.setTitle("Login User", for: .normal)
        
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
        
        self.view.addSubview(getRecipesButton)
        self.view.addSubview(loginUserButton)
        self.view.addSubview(getIngredientsButton)
        self.view.addSubview(createUserButton)
        self.view.addSubview(openLoginViewButton)
        
        //MARK: Test Button 1 Constraints
        getRecipesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getRecipesButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        getRecipesButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        getRecipesButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        getRecipesButton.addTarget(self, action: #selector(getRecipes), for: .touchUpInside)
        
        //MARK: Test Button 2 Constraints
        loginUserButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginUserButton.topAnchor.constraint(equalTo: getRecipesButton.bottomAnchor, constant: 10).isActive = true
        loginUserButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        loginUserButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        loginUserButton.addTarget(self, action: #selector(loginUserAction), for: .touchUpInside)
        
        //MARK: Test Button 3 Constraints
        getIngredientsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getIngredientsButton.topAnchor.constraint(equalTo: loginUserButton.bottomAnchor, constant: 10).isActive = true
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
    }
    
    @objc func getRecipes() {
        print("Calling Recieps Endpoint")
        LocalHostTest.shared.getRecipeSuggestions()
    }
    
    @objc func loginUserAction() {
        print("Calling User Endpoint: POST LOGIN")
        LocalHostTest.shared.loginUser()
    }
    
    @objc func getIngredientsAction() {
        print("Calling Ingredients Endpoint")
        LocalHostTest.shared.getIngredientsList()
    }
    
    @objc func createUserAction() {
        print("Calling User Endpoint: POST CREATE")
        LocalHostTest.shared.createUser()
    }
    
    @objc func openLoginView() {
        print("Opening Login View")
        let presentVC = LoginViewController()
        present(presentVC, animated: true, completion: nil)
    }
}


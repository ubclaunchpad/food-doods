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
        var getUserButton = UIButton()
        getUserButton.translatesAutoresizingMaskIntoConstraints = false
        getUserButton.layer.cornerRadius = 10
        getUserButton.backgroundColor = .green
        getUserButton.setTitle("Get User", for: .normal)
        
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
        openLoginViewButton.backgroundColor = .yellow
        openLoginViewButton.setTitle("Create User", for: .normal)
        
        self.view.addSubview(getRecipesButton)
        self.view.addSubview(getUserButton)
        self.view.addSubview(getIngredientsButton)
        self.view.addSubview(createUserButton)
        self.view.addSubview(openLoginViewButton)
        
        //MARK: Test Button 1 Constraints
        getRecipesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getRecipesButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        getRecipesButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        getRecipesButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        getRecipesButton.addTarget(self, action: #selector(getRecipes), for: .touchUpInside)
        
        //MARK: Test Button 2 Constraints
        getUserButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getUserButton.topAnchor.constraint(equalTo: getRecipesButton.bottomAnchor, constant: 10).isActive = true
        getUserButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        getUserButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        getUserButton.addTarget(self, action: #selector(getUserAction), for: .touchUpInside)
        
        //MARK: Test Button 3 Constraints
        getIngredientsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getIngredientsButton.topAnchor.constraint(equalTo: getUserButton.bottomAnchor, constant: 10).isActive = true
        getIngredientsButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        getIngredientsButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        getIngredientsButton.addTarget(self, action: #selector(getIngredientsAction), for: .touchUpInside)
        
        //MARK: Test Button 4 Constraints
        createUserButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        createUserButton.topAnchor.constraint(equalTo: getIngredientsButton.bottomAnchor, constant: 10).isActive = true
        createUserButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        createUserButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        createUserButton.addTarget(self, action: #selector(createUserAction), for: .touchUpInside)
        
        //MARK: Open Login View Button Constraints
        openLoginViewButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        openLoginViewButton.topAnchor.constraint(equalTo: getIngredientsButton.bottomAnchor, constant: 10).isActive = true
        openLoginViewButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        openLoginViewButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        openLoginViewButton.addTarget(self, action: #selector(openLoginView), for: .touchUpInside)
    }
    
    @objc func getRecipes() {
        print("Calling Recieps Endpoint")
        LocalHostTest.shared.getRecipeSuggestions()
    }
    
    @objc func getUserAction() {
        print("Calling User Endpoint: GET")
        LocalHostTest.shared.getUser()
    }
    
    @objc func getIngredientsAction() {
        print("Calling Ingredients Endpoint")
        LocalHostTest.shared.getIngredientsList()
    }
    
    @objc func createUserAction() {
        print("Calling User Endpoint: POST")
        LocalHostTest.shared.createUser()
    }
    
    @objc func openLoginView() {
        print("Opening Login View")
        let presentVC = LoginViewController()
        present(presentVC, animated: true, completion: nil)
    }
}


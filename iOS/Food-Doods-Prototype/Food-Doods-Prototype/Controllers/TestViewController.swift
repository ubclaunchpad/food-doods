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
        var testButton1 = UIButton()
        testButton1.translatesAutoresizingMaskIntoConstraints = false
        testButton1.layer.cornerRadius = 100
        testButton1.backgroundColor = .blue
        testButton1.setTitle("Get Recipes", for: .normal)
        
        //MARK: Test Button 2
        var getUserButton = UIButton()
        getUserButton.translatesAutoresizingMaskIntoConstraints = false
        getUserButton.layer.cornerRadius = 100
        getUserButton.backgroundColor = .green
        getUserButton.setTitle("Get User", for: .normal)
        
        //MARK: Test Button 3
        var getIngredientsButton = UIButton()
        getIngredientsButton.translatesAutoresizingMaskIntoConstraints = false
        getIngredientsButton.layer.cornerRadius = 100
        getIngredientsButton.backgroundColor = .red
        getIngredientsButton.setTitle("Get Ingredients", for: .normal)
        
        self.view.addSubview(testButton1)
        self.view.addSubview(getUserButton)
        self.view.addSubview(getIngredientsButton)
        
        //MARK: Test Button 1 Constraints
        testButton1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        testButton1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        testButton1.heightAnchor.constraint(equalToConstant: 200).isActive = true
        testButton1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        testButton1.addTarget(self, action: #selector(getRecipes), for: .touchUpInside)
        
        //MARK: Test Button 2 Constraints
        getUserButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getUserButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 250).isActive = true
        getUserButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        getUserButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        getUserButton.addTarget(self, action: #selector(getUserAction), for: .touchUpInside)
        
        //MARK: Test Button 3 Constraints
        getIngredientsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        getIngredientsButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -250).isActive = true
        getIngredientsButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        getIngredientsButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        getIngredientsButton.addTarget(self, action: #selector(getIngredientsAction), for: .touchUpInside)
    }
    
    @objc func getRecipes() {
        print("Calling Recieps Endpoint")
        LocalHostTest.shared.getRecipeSuggestions()
    }
    
    @objc func getUserAction() {
        print("Calling User Endpoint")
        LocalHostTest.shared.getUser()
    }
    
    @objc func getIngredientsAction() {
        print("Calling Ingredients Endpoint")
        LocalHostTest.shared.getIngredientsList()
    }
}


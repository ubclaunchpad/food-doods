//
//  RootTabBarController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-14.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    lazy var button: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.backgroundColor = .black
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.setTitle("Add", for: .normal)
        button.clipsToBounds = true
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = NavigationController(rootViewController: PantryViewController())
        firstViewController.tabBarItem = UITabBarItem()
        firstViewController.tabBarItem.title = "Pantry"
        firstViewController.tabBarItem.tag = 0
        let secondViewController = SecondViewController()
        secondViewController.tabBarItem = UITabBarItem()
        secondViewController.tabBarItem.title = "Recipes"
        secondViewController.tabBarItem.tag = 1

        let tabBarList = [firstViewController, secondViewController]
        viewControllers = tabBarList

        self.view.addSubview(button)
        //THIS NEEDS TO BE CHANGED LATER
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }

}

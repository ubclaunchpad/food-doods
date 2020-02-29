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
        button.clipsToBounds = true
        button.layer.masksToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.backgroundColor = .white
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = .zero
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 7
        button.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 60, height: 60), cornerRadius: 30).cgPath
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        
        //MARK: TEMPORARY TEST ACTION
        #warning("TEMPORARY BUTTON ACTION")
        button.addTarget(self, action: #selector(network), for: .touchUpInside)
        
        return button
    }()
    
    @objc func network() {
        LocalHostTest.shared.testCall()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = NavigationController(rootViewController: PantryViewController())
        firstViewController.tabBarItem = UITabBarItem()
        firstViewController.tabBarItem.title = "Pantry"
        firstViewController.tabBarItem.tag = 0
        firstViewController.tabBarItem.image = UIImage(systemName: "tray.2")
        
        let secondViewController = NavigationController(rootViewController: RecipesViewController())
        secondViewController.tabBarItem = UITabBarItem()
        secondViewController.tabBarItem.title = "Recipes"
        secondViewController.tabBarItem.tag = 1
        secondViewController.tabBarItem.image = UIImage(systemName: "book")

        
        let thirdViewController = NavigationController(rootViewController: ShoppingListViewController())
        thirdViewController.tabBarItem = UITabBarItem()
        thirdViewController.tabBarItem.title = "Shopping List"
        thirdViewController.tabBarItem.tag = 2
        thirdViewController.tabBarItem.image = UIImage(systemName: "list.dash")

        
        let fourthViewController = NavigationController(rootViewController: SettingsViewController())
        fourthViewController.tabBarItem = UITabBarItem()
        fourthViewController.tabBarItem.title = "Settings"
        fourthViewController.tabBarItem.tag = 3
        fourthViewController.tabBarItem.image = UIImage(systemName: "gear")
        
        let fifthVC = TestViewController()
        fifthVC.tabBarItem = UITabBarItem()
        fifthVC.tabBarItem.title = "TESTING"
        fifthVC.tabBarItem.tag = 3
        fifthVC.tabBarItem.image = UIImage(systemName: "pencil-slash")


        let tabBarList = [firstViewController, secondViewController, thirdViewController, fourthViewController, fifthVC]
        viewControllers = tabBarList

        self.view.addSubview(button)
        //THIS NEEDS TO BE CHANGED LATER
        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }

}

//
//  RootTabBarController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-14.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit
import AlanYanHelpers

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
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = NavigationController(rootViewController: PantryViewController())
        firstViewController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "CircularStd-Bold", size: 36)!]
        firstViewController.tabBarItem = UITabBarItem()
        firstViewController.tabBarItem.title = "Pantry"
        firstViewController.tabBarItem.tag = 0
        firstViewController.tabBarItem.image = UIImage(systemName: "tray.2")
        
        let secondViewController = NavigationController(rootViewController: RecipesViewController())
        secondViewController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "CircularStd-Bold", size: 36)!]
        secondViewController.tabBarItem = UITabBarItem()
        secondViewController.tabBarItem.title = "Recipes"
        secondViewController.tabBarItem.tag = 1
        secondViewController.tabBarItem.image = UIImage(systemName: "book")

        
        let thirdViewController = NavigationController(rootViewController: ShoppingListViewController())
        thirdViewController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "CircularStd-Bold", size: 36)!]
        thirdViewController.tabBarItem = UITabBarItem()
        thirdViewController.tabBarItem.title = "Shopping List"
        thirdViewController.tabBarItem.tag = 2
        thirdViewController.tabBarItem.image = UIImage(systemName: "list.dash")

        
        let fourthViewController = NavigationController(rootViewController: SettingsViewController())
        fourthViewController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "CircularStd-Bold", size: 36)!]
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



class CustomTabViewController: UITabBarController {
    var ourTabBar: CustomTabBar!
    var items: [TabBarButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for item in ourTabBar.tabItems {
            item.userDefinedConstraintDict["width"]?.constant = (self.view.frame.width-40)/4
        }
    }

    func setupView() {}
    
    func setTabBar(items: [TabBarButton]) {
        self.items = items
        ourTabBar = CustomTabBar(items: items)
        guard let bar = ourTabBar else { return }
        
        bar.backgroundColor = .white
        bar.addCorners(radius: 15, corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner]).done()
        ShadowUIView(colour: UIColor(hex: 0xE0E0E0, alpha: 1),subLayer: bar).setSuperview(self.view as Any).addBottom().addTrailing().addLeading().addTop(anchor: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80).done()
            
        for i in 0 ..< items.count {
            items[i].tag = i
            items[i].addTarget(self, action: #selector(switchTab), for: .touchUpInside)
        }
    }

    @objc func switchTab(button: TabBarButton) {
        print("clicked")
        selectedIndex = button.tag
        items.forEach {
            $0.headerImage.image = $0.headerImage.image?.withTintColor(.black, renderingMode: .alwaysOriginal)
            $0.headerLabel.textColor = .black
        }
        let color = UIColor(displayP3Red: 27/255, green: 191/255, blue: 0, alpha: 1)
        button.headerImage.image = button.headerImage.image?.withTintColor(color, renderingMode: .alwaysOriginal)
        button.headerLabel.textColor = color
    }
}

class TabBarViewController: CustomTabViewController {
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    override func setupView() {
        let pantryButton = TabBarButton(title: "Pantry", image: UIImage(named: "fridge")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        let color = UIColor(displayP3Red: 27/255, green: 191/255, blue: 0, alpha: 1)
        pantryButton.headerImage.image = pantryButton.headerImage.image?.withTintColor(color, renderingMode: .alwaysOriginal)
        pantryButton.headerLabel.textColor = color
        let recipeButton = TabBarButton(title: "Recipes", image: UIImage(named: "recipebook")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        let shoppingButton = TabBarButton(title: "Shopping List", image: UIImage(named: "shopping")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        let settingsButton = TabBarButton(title: "Settings", image: UIImage(named: "settings")?.withTintColor(.black, renderingMode: .alwaysOriginal))


        let firstViewController = NavigationController(rootViewController: PantryViewController())
        let secondViewController = NavigationController(rootViewController: RecipesViewController())
        let thirdViewController = NavigationController(rootViewController: ShoppingListViewController())
        let fourthViewController = NavigationController(rootViewController: SettingsViewController())

        setTabBar(items: [pantryButton, recipeButton, shoppingButton, settingsButton])
        viewControllers = [firstViewController, secondViewController, thirdViewController, fourthViewController]
        
        
        addButton.addCorners(30).done()
        addButton.backgroundColor = .white
        ShadowUIView(colour: UIColor(hex: 0xD8D8D8),radius: 7, subLayer: addButton).setSuperview(self.view).addBottom(constant: -70).addWidth(withConstant: 60).addHeight(withConstant: 60).addCenterX().done()
    }
}

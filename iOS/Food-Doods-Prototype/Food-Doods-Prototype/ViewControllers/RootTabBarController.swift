//
//  RootTabBarController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-14.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstView = MainTableViewController()
        firstView.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let secondView = SecondViewController()
        secondView.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let tabBarList = [firstView, secondView]
        viewControllers = tabBarList
        
        //MARK: - Test
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = "I'm a test label"
        self.view.addSubview(label)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

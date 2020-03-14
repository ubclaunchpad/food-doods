//
//  LoginViewController.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-03-14.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginView = LoginView()
        // set up this view
        
        
        self.view = loginView
    }
}

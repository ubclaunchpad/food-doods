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
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginView = LoginView()
        // set up this view
        usernameTextField = loginView.usernameTextField
        passwordTextField = loginView.passwordTextField
        loginView.loginButton.addTarget(self, action: #selector(callLoginAPI), for: .touchUpInside)
        
        self.view = loginView
    }
    
    @objc func callLoginAPI() {
        //grab text from text fields
        let user = usernameTextField.text
        let password = passwordTextField.text
        
        self.dismiss(animated: true, completion: nil)
    }
}

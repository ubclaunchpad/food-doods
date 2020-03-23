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
        loginView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        self.view = loginView
    }
    
    @objc func callLoginAPI() {
        //grab text from text fields
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        let lastToken = UserDefaults.standard.string(forKey: "token")
        print("lastToken: \(lastToken)")
        
        if let user = username, let pass = password {
            if let token = lastToken {
                LocalHostTest.shared.loginUser(username: user, password: pass, token: token)
            } else {
                LocalHostTest.shared.loginUser(username: user, password: pass, token: "")
            }
            
        }
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}

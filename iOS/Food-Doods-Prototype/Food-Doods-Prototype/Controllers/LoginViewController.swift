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
    var loginView: LoginViewDesign!
    
    var loginDelegate: LoginDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginViewDesign()
        // set up this view
        usernameTextField = loginView.usernameTextField
        passwordTextField = loginView.passwordTextField
        loginView.loginButton.addTarget(self, action: #selector(callLoginAPI), for: .touchUpInside)
        loginView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        self.view = loginView
    }
    
    @objc func insertToken() {
        UserDefaults.standard.set("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImVhdEhlYWx0aHkiLCJpYXQiOjE1ODY0NTQ3OTAxNDgsImV4cCI6MTU4NjQ1NTM5NDk0OH0.fOLcqSyLZtfRrwcEWIGfW18igMGGaBhdQ6TXfze7C6g", forKey: "token")
    }
    
    @objc func callLoginAPI() {
        //grab text from text fields
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        let lastToken = UserDefaults.standard.string(forKey: "token")
        
        if let user = username, let pass = password, let token = lastToken {
            UserAPIUtil.shared.loginUser(username: user, password: pass, token: token, completion: handleResult)
        }
    }
    
    lazy var handleResult: (Bool) -> Void = {
        success in
        
        if (success) {
            self.loginView.statusLabel.text = "Authentication Successful!"
            self.loginView.statusLabel.backgroundColor = UIColor(hex: 0x58D626)
            self.loginView.statusLabel.isHidden = false

            self.logTheUserIn()
            
        } else {
            self.loginView.statusLabel.text = "Authentication Failed :("
            self.loginView.statusLabel.backgroundColor = UIColor(hex: 0xFF3730)
            self.loginView.statusLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.loginView.statusLabel.isHidden = true
            })
        }
    }
    
    func logTheUserIn() {
        if let delegate = self.loginDelegate {
            delegate.fetchIngredients()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.00, execute: {
            self.dismissView()
        })
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}

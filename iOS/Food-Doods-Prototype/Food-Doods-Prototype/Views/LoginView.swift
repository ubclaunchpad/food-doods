//
//  LoginView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-03-14.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.text = "Login"
        return label
    }()
    
    var usernameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.clipsToBounds = true
        field.layer.cornerRadius = 20
        field.backgroundColor = .gray
        return field
    }()
    
    var passwordTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.clipsToBounds = true
        field.layer.cornerRadius = 20
        field.backgroundColor = .gray
        return field
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.backgroundColor = .blue
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        
        setupConstraints()
    }
    private func setupConstraints() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
    }
    
    
    
    
}

//
//  LoginView.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2020-03-21.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

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
        return field
    }()
    
    var passwordTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        return field
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        
        setupConstraints()
    }
    private func setupConstraints() {
        
        usernameTextField
        
        
    }
}

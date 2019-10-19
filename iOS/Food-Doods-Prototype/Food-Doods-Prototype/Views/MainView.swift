//
//  MainView.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-10-18.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class MainView: UIView {
    lazy var text: UILabel = {
        let textLabel = UILabel()
        //frame: CGRect(x: 0, y: 0, width: 200, height: 70)
        textLabel.textAlignment = .center
        textLabel.text = "Hello World"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override class var requiresConstraintBasedLayout: Bool {
      return true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupView()
    }
    func setupView() {
        backgroundColor = .red
        
        addSubview(text)
        setupConstraints()
    }
    
    
    
    //MARK: Constraints Setup
    private func setupConstraints() {
        text.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        text.widthAnchor.constraint(equalToConstant: 200).isActive = true
        text.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}

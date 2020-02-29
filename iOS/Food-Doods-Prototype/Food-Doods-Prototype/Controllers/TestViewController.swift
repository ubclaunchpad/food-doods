//
//  TestViewController.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2020-02-29.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        var testButton = UIButton()
        testButton.translatesAutoresizingMaskIntoConstraints = false
        testButton.layer.cornerRadius = 100
        testButton.backgroundColor = .green
        testButton.setTitle("Test", for: .normal)
        
        self.view.addSubview(testButton)
        
        testButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        testButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        testButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        testButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        testButton.addTarget(self, action: #selector(testAPIButton), for: .touchUpInside)
    }
    
    @objc func testAPIButton() {
        //MARK: TODO: Wren testing API
    }
}


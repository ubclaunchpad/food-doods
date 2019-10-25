//
//  ItemView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-19.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class ItemView: UIView {
    
    lazy var itemQuantity: UILabel = {
        let title = UILabel()

        title.text = "Item Quantity"
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        
        return title
    }()
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
        setupView()
    }
    
    
    private func setupView() {
        backgroundColor = .white
        
        self.addSubview(itemQuantity)
        setupConstraints()
    }
    
    //MARK: Constraints Setup
    private func setupConstraints() {
        itemQuantity.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        itemQuantity.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        itemQuantity.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
    }
    
}

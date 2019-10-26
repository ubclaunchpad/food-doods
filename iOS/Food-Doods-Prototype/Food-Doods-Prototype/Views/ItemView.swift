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
    
    lazy var itemIcon: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2.0
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
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
        itemIcon.image = UIImage(named: "carrot")
        
        self.addSubview(itemQuantity)
        self.addSubview(itemIcon)
        setupConstraints()
    }
    
    //MARK: Constraints Setup
    //NOTE: Change the specifics of this later, this is just some hello world boilerplate
    private func setupConstraints() {
        itemQuantity.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        itemQuantity.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        itemQuantity.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true

        
        itemIcon.topAnchor.constraint(equalTo: itemQuantity.bottomAnchor, constant: 0).isActive = true
        itemIcon.heightAnchor.constraint(equalToConstant: 300).isActive = true
        itemIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        itemIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        
    }
    
    
}

//
//  ItemView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-19.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class ItemView: UIView {
    lazy var itemName: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var amountText: UILabel = {
        let label = UILabel()
        
        label.text = "Amount"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var itemQuantity: UILabel = {
        let label = UILabel()

        label.text = "#"
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var expiringText: UILabel = {
        let label = UILabel()
        
        label.text = "Expiring in"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var expiryDate: UILabel = {
        let label = UILabel()

        label.text = "# days"
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
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
    }
    
    
    private func setupView() {
        backgroundColor = .white
        
        self.addSubview(itemName)
        self.addSubview(amountText)
        self.addSubview(itemQuantity)
        
        self.addSubview(expiringText)
        self.addSubview(expiryDate)
        
        self.addSubview(itemIcon)
        
        
        
        setupConstraints()
    }
    
    //MARK: - Constraints Setup
    private func setupConstraints() {
        //--- itemName Constraints ---//
        itemName.leftAnchor.constraint(equalTo: itemIcon.rightAnchor, constant: 21).isActive = true
        itemName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        //--- amountText Constraints ---//
        amountText.leftAnchor.constraint(equalTo: itemIcon.rightAnchor, constant: 21).isActive = true
        amountText.bottomAnchor.constraint(equalTo: itemQuantity.topAnchor, constant: -10).isActive = true
        
        //--- itemQuantity Constraints ---//
        itemQuantity.leftAnchor.constraint(equalTo: itemIcon.rightAnchor, constant: 21).isActive = true
        itemQuantity.bottomAnchor.constraint(equalTo: itemIcon.bottomAnchor, constant: 0).isActive = true
        
        //--- expiringText Constraints ---//
        expiringText.leftAnchor.constraint(equalTo: amountText.rightAnchor, constant: 21).isActive = true
        expiringText.bottomAnchor.constraint(equalTo: expiryDate.topAnchor, constant: -10).isActive = true
        
        //--- expiryDate Constraints ---//
        expiryDate.leftAnchor.constraint(equalTo: amountText.rightAnchor, constant: 21).isActive = true
        expiryDate.bottomAnchor.constraint(equalTo: itemIcon.bottomAnchor, constant: 0).isActive = true
        
        //--- itemIcon Constraints ---//
        itemIcon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        itemIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 21).isActive = true
        itemIcon.widthAnchor.constraint(equalToConstant: 150).isActive = true
        itemIcon.heightAnchor.constraint(equalToConstant: 150).isActive = true

        
    }
    
    
}

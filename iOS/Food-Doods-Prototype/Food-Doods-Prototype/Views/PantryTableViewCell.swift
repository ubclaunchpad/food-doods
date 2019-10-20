//
//  PantryTableViewCell.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-10-19.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit


class PantryTableViewCell: UITableViewCell {
    
    lazy var foodImage: UIImageView = {
        let foodImage = UIImageView()
        foodImage.layer.cornerRadius = 25
        foodImage.image = UIImage()
        return foodImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
}

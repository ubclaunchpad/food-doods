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
        foodImage.layer.masksToBounds = true
        foodImage.layer.borderWidth = 3
        foodImage.layer.borderColor = UIColor.red.cgColor
        foodImage.layer.cornerRadius = 30
        foodImage.contentMode = .scaleAspectFill
        foodImage.clipsToBounds = true
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        return foodImage
    }()
    lazy var mainText: UILabel = {
        let mainText = UILabel()
        mainText.text = "Cell"
        mainText.translatesAutoresizingMaskIntoConstraints = false
        return mainText
    }()
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupView()
    }
    
    func setupView() {
        addSubview(foodImage)
        addSubview(mainText)
        setupConstraints()
    }
    
    func setupConstraints() {
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        foodImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        foodImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        mainText.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true
        mainText.heightAnchor.constraint(equalToConstant: 100).isActive = true
        mainText.rightAnchor.constraint(equalTo: rightAnchor, constant: 10).isActive = true
        mainText.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
}

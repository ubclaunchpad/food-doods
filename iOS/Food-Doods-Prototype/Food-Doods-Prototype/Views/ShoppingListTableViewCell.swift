//
//  ShoppingListTableViewCell.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2020-02-01.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    var foodImage: UIImageView = {
        let foodImage = UIImageView()
        foodImage.image = UIImage(named: "carrot")
        foodImage.layer.masksToBounds = true
        //foodImage.layer.cornerRadius = 30
        foodImage.contentMode = .scaleAspectFill
        foodImage.clipsToBounds = true
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        return foodImage
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Grocery List Item"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "300g"
        label.font = UIFont(name: "Arial", size: 15)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$5.99"
        label.font = UIFont(name: "Arial", size: 15)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var selectedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        setupView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10));
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(foodImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(selectedIcon)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-20, height: 80), cornerRadius: 10).cgPath
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        
        setupConstraints()
    }
    
    func setupConstraints() {        
        foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        foodImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
    
        nameLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        amountLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        priceLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 0).isActive = true
        
        selectedIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        selectedIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        selectedIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        selectedIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

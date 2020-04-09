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
        label.font = UIFont(name: "CircularStd-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "300g"
        label.font = UIFont(name: "CircularStd-Book", size: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var selectedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square")?.withTintColor(.black, renderingMode: .alwaysOriginal)
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 24, bottom: 4, right: 24));
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(foodImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(selectedIcon)
        contentView.layer.cornerRadius = 13
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-48, height: 66), cornerRadius: 13).cgPath
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        
        setupConstraints()
    }
    
    func setupConstraints() {
        selectedIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        selectedIcon.heightAnchor.constraint(equalToConstant: 22).isActive = true
        selectedIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        selectedIcon.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        foodImage.leftAnchor.constraint(equalTo: selectedIcon.rightAnchor, constant: 12).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 22).isActive = true
        foodImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: 22).isActive = true
    
        nameLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 12).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        
        amountLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 12).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        amountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
    }
}

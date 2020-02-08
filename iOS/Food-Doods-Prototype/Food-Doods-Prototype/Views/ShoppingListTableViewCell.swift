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
        foodImage.layer.masksToBounds = true
        //foodImage.layer.cornerRadius = 30
        foodImage.contentMode = .scaleAspectFill
        foodImage.clipsToBounds = true
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        return foodImage
    }()
    var mainText: UILabel = {
        let mainText = UILabel()
        mainText.text = "Cell"
        mainText.translatesAutoresizingMaskIntoConstraints = false
        return mainText
    }()
    var amountText: UILabel = {
        let mainText = UILabel()
        mainText.text = "300g"
        mainText.font = UIFont(name: "Arial", size: 10)
        mainText.textColor = .gray
        mainText.translatesAutoresizingMaskIntoConstraints = false
        return mainText
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
        contentView.addSubview(mainText)
        contentView.addSubview(amountText)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-20, height: 60), cornerRadius: 10).cgPath
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        
        setupConstraints()
    }
    
    func setupConstraints() {        
        foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        foodImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
    
        mainText.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true
        mainText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        mainText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        mainText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        amountText.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true
        amountText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        amountText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        amountText.topAnchor.constraint(equalTo: mainText.bottomAnchor, constant: 0).isActive = true
    }
}

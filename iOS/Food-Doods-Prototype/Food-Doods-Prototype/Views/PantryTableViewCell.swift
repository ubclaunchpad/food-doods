//
//  PantryTableViewCell.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-10-19.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit


class PantryTableViewCell: UITableViewCell {
    
    var foodImage: UIImageView = {
        let foodImage = UIImageView()
        foodImage.layer.masksToBounds = true
        //foodImage.layer.cornerRadius = 30
        foodImage.contentMode = .scaleAspectFit
        foodImage.clipsToBounds = true
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        return foodImage
    }()
    var mainText: UILabel = {
        let mainText = UILabel()
        mainText.text = "Cell"
        mainText.font = UIFont(name: "CircularStd-Bold", size: 18)
        mainText.translatesAutoresizingMaskIntoConstraints = false
        return mainText
    }()
    var expiringText: UILabel = {
        let mainText = UILabel()
        mainText.font = UIFont(name: "CircularStd-Book", size: 10)
        mainText.textColor = .gray
        mainText.text = "expiring in 2 days"
        mainText.translatesAutoresizingMaskIntoConstraints = false
        return mainText
    }()
    var amountText: UILabel = {
        let mainText = UILabel()
        mainText.text = "300g"
        mainText.font = UIFont(name: "CircularStd-Book", size: 12)
        mainText.textColor = .gray
        mainText.translatesAutoresizingMaskIntoConstraints = false
        return mainText
    }()
    var sectionText: UILabel = {
        let mainText = UILabel()
        mainText.font = UIFont(name: "CircularStd-Book", size: 12)
        mainText.textColor = .gray
        mainText.text = "location"
        mainText.translatesAutoresizingMaskIntoConstraints = false
        return mainText
    }()
    var expiryBar: UIProgressView = {
        let bar = UIProgressView()
        bar.setProgress(1.0, animated: true)
        bar.tintColor = UIColor.green
        
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24));
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(foodImage)
        contentView.addSubview(mainText)
        contentView.addSubview(expiringText)
        contentView.addSubview(amountText)
        contentView.addSubview(sectionText)
        contentView.addSubview(expiryBar)
        setupConstraints()
        contentView.layer.cornerRadius = 13
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-48, height: 80), cornerRadius: 13).cgPath
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupConstraints() {
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 23).isActive = true
        foodImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        foodImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
    
        mainText.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 17).isActive = true
        mainText.heightAnchor.constraint(equalToConstant: 23).isActive = true
        mainText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -70).isActive = true
        mainText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        
        amountText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21).isActive = true
        amountText.leftAnchor.constraint(equalTo: mainText.rightAnchor, constant: 22).isActive = true
        amountText.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        sectionText.leftAnchor.constraint(equalTo: mainText.rightAnchor, constant: 22).isActive = true
        sectionText.heightAnchor.constraint(equalToConstant: 15).isActive = true
        sectionText.topAnchor.constraint(equalTo: amountText.bottomAnchor, constant: 12).isActive = true
        
        expiringText.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 17).isActive = true
        expiringText.heightAnchor.constraint(equalToConstant: 13).isActive = true
        expiringText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -70).isActive = true
        expiringText.topAnchor.constraint(equalTo: mainText.bottomAnchor).isActive = true
        
        expiryBar.leftAnchor.constraint(equalTo: mainText.leftAnchor).isActive = true
        expiryBar.rightAnchor.constraint(equalTo: sectionText.leftAnchor, constant: -20).isActive = true
        expiryBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        expiryBar.topAnchor.constraint(equalTo: expiringText.bottomAnchor).isActive = true
    }
}

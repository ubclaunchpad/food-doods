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
        //foodImage.layer.cornerRadius = 30
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
    lazy var expiringText: UILabel = {
        let mainText = UILabel()
        mainText.font = UIFont(name: "Arial", size: 10)
        mainText.textColor = .gray
        mainText.text = "expiring in 2 days"
        mainText.translatesAutoresizingMaskIntoConstraints = false
        return mainText
    }()
    lazy var amountText: UILabel = {
        let mainText = UILabel()
        mainText.text = "300g"
        mainText.font = UIFont(name: "Arial", size: 10)
        mainText.textColor = .gray
        mainText.translatesAutoresizingMaskIntoConstraints = false
        return mainText
    }()
    lazy var sectionText: UILabel = {
        let mainText = UILabel()
        mainText.font = UIFont(name: "Arial", size: 10)
        mainText.textColor = .gray
        mainText.text = "location"
        mainText.translatesAutoresizingMaskIntoConstraints = false
        return mainText
    }()
    
    lazy var expiryBar: UIProgressView = {
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10));
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
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-20, height: 103), cornerRadius: 30).cgPath
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupConstraints() {
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        foodImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        foodImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
    
        mainText.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true
        mainText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        mainText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -70).isActive = true
        mainText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        
        amountText.leftAnchor.constraint(equalTo: mainText.rightAnchor, constant: 25).isActive = true
        amountText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        amountText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        amountText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        
        sectionText.leftAnchor.constraint(equalTo: mainText.rightAnchor, constant: 25).isActive = true
        sectionText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        sectionText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        sectionText.topAnchor.constraint(equalTo: amountText.bottomAnchor).isActive = true
        
        expiringText.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true
        expiringText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        expiringText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -70).isActive = true
        expiringText.topAnchor.constraint(equalTo: mainText.bottomAnchor).isActive = true
        
        expiryBar.leftAnchor.constraint(equalTo: mainText.leftAnchor).isActive = true
        expiryBar.rightAnchor.constraint(equalTo: sectionText.leftAnchor, constant: -20).isActive = true
        expiryBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        expiryBar.topAnchor.constraint(equalTo: expiringText.bottomAnchor).isActive = true
    }
}

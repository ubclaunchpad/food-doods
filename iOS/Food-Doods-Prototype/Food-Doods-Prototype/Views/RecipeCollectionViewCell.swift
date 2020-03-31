//
//  RecipeCollectionViewCell.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-11-02.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    var recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "carrot")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Poutine"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Bold", size: 12)
        return label
    }()
    var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "30 Minutes"
        label.font = UIFont(name: "CircularStd-Book", size: 10)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var difficultyLabel: UILabel = {
        let label = UILabel()
        label.text = "Easy"
        label.font = UIFont(name: "CircularStd-Book", size: 10)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "4/15 Ingredients"
        label.font = UIFont(name: "CircularStd-Book", size: 10)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.backgroundColor = .red
        return view
    }()
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(recipeImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(difficultyLabel)
        contentView.addSubview(ingredientLabel)
        contentView.addSubview(roundedView)
        
        setupConstraints()
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 310), cornerRadius: 8).cgPath
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupConstraints() {
        roundedView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        roundedView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        roundedView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true

        
        recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        recipeImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        recipeImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        recipeImage.heightAnchor.constraint(equalToConstant: 227).isActive = true
        
        
        nameLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 8).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 6).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        difficultyLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor).isActive = true
        difficultyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        difficultyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        difficultyLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        ingredientLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor).isActive = true
        ingredientLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        ingredientLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        ingredientLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        
        
    }
    
}

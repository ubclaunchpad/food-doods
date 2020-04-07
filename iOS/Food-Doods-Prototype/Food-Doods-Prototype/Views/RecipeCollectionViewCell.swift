//
//  RecipeCollectionViewCell.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-11-02.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit
import AlanYanHelpers
class RecipeCollectionViewCell: UICollectionViewCell {
    var recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "carrot")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Poutine"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Bold", size: 12)
        return label
    }()
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    var roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.backgroundColor = .red
        return view
    }()
    var heartImage = ContentFitImageView()
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
        contentView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 304), cornerRadius: 8).cgPath
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
        
        stackView.setSuperview(contentView).addTop(anchor: nameLabel.bottomAnchor, constant: 2).addLeft(constant: 6).addRight().addHeight(withConstant: 45).done()
        
        stackView.addArrangedSubview(RecipeImageTextView(image: UIImage(systemName: "timer")?.withTintColor(.gray, renderingMode: .alwaysOriginal), size: 10, title:  ""))
        stackView.addArrangedSubview(RecipeImageTextView(image: UIImage(systemName: "circle")?.withTintColor(.gray, renderingMode: .alwaysOriginal), size: 10, title: ""))
        stackView.addArrangedSubview(RecipeImageTextView(image: UIImage(systemName: "person.3")?.withTintColor(.gray, renderingMode: .alwaysOriginal), size: 10, title: ""))
        
        heartImage.setSuperview(contentView).addTop(constant: 5).addRight(constant: -5).addWidth(withConstant: 25).addHeight(withConstant: 25).done()
    }
    
}

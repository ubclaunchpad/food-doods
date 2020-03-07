//
//  RecipeDetailedView.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2020-02-29.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import UIKit


class RecipeInfoCell: UIView {
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    convenience init(image: UIImage, text: String, size: CGFloat) {
        self.init()
        imageView.image = image
        label.text = text
        label.font = UIFont.systemFont(ofSize: size)
    }
    override init(frame: CGRect) {
         super.init(frame: frame)
         setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(imageView)
        addSubview(label)
        setupConstraints()
    }

    //MARK: - Constraints Setup
    private func setupConstraints() {
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 5).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
    }
}


class RecipeDetailedView: UIView {
    var viewModel: Recipe! {
        didSet {
            recipeImage.image = viewModel.image
            recipeLabel.text = viewModel.name
        }
    }
    
    //MARK: Subview Declarations
    var recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.cornerRadius = 20
        return view
    }()
    var recipeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
   
    func setupView() {
        addSubview(recipeImage)
        addSubview(bottomView)
        bottomView.addSubview(recipeLabel)
        setupConstraints()
    }
   
    //MARK: - Constraints Setup
    private func setupConstraints() {
        recipeImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        recipeImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        recipeImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        recipeImage.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
        
        bottomView.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: -20).isActive = true
        bottomView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        recipeLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 20).isActive = true
        recipeLabel.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 20).isActive = true
        recipeLabel.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -20).isActive = true
        
    }
}

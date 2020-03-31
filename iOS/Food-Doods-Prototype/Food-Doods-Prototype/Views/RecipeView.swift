//
//  RecipeView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-19.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit
class SearchBarView: UIView {
    var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    var searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search for recipes, ingredients, cuisine"
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        return textField
    }()
    var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = UIColor(hex: 0x23E103)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = UIColor(named: "menuColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    func setupView() {
        addSubview(backView)
        backView.addSubview(searchField)
        backView.addSubview(searchButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        backView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        searchButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        searchButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        searchButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        searchField.rightAnchor.constraint(equalTo: searchButton.leftAnchor, constant: -10).isActive = true
        searchField.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        searchField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        searchField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true

    }
}

class RecipeView: UIView {
    var searchBar = SearchBarView()
    var segmentControl: CustomSegmentedControl = {
        let control = CustomSegmentedControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.setButtonTitles(buttonTitles: ["Favorites", "Suggested"])
        control.selectorViewColor = UIColor(displayP3Red: 27/255, green: 191/255, blue: 0, alpha: 1)
        control.selectorTextColor = UIColor(displayP3Red: 27/255, green: 191/255, blue: 0, alpha: 1)
        return control
    }()
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsSelection = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    func setupView() {
        addSubview(searchBar)
        addSubview(segmentControl)
        addSubview(collectionView)
        setupConstraints()
    }
    func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        segmentControl.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        segmentControl.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        segmentControl.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 5).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
}

extension UIColor {
    
    /**
        Constructor allowing for hex values of type "0xFFFFFF"
     */
    public convenience init(hex: Int, alpha: Double? = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255, green: CGFloat((hex >> 8) & 0xFF) / 255, blue: CGFloat(hex & 0xFF) / 255, alpha: CGFloat(alpha!))
    }
}

//
//  RecipeView.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-19.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit


class RecipeView: UIView {
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.backgroundColor = .yellow
        return search
    }()
    lazy var text: UILabel = {
        let textLabel = UILabel()
        textLabel.textAlignment = .center
        textLabel.text = "Hello World"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    lazy var collectionView: UICollectionView = {
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
        setupView()

    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    func setupView() {
        addSubview(searchBar)
        addSubview(text)
        addSubview(collectionView)
        setupConstraints()
    }
    func setupConstraints() {
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: leftAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        text.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        text.widthAnchor.constraint(equalToConstant: 200).isActive = true
        text.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}

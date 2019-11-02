//
//  RecipeCollectionViewCell.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-11-02.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        layer.masksToBounds = true
        clipsToBounds = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupView()
    }
    
    func setupView() {
        setupConstraints()

    }
    
    func setupConstraints() {
    }
    
}

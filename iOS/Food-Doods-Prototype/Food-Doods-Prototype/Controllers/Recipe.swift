//
//  Recipe.swift
//  Food-Doods-Prototype
//
//  Created by Alan Yan on 2019-11-02.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit


struct Recipe {
    var name: String
    var image: UIImage?
    var ingredients: [Item]
    
    init(name: String, image: UIImage?, ingredients: [Item]) {
        self.name = name
        self.image = image
        self.ingredients = ingredients
    }
}



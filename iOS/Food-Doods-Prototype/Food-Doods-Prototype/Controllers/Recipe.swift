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
    var ingredientsNeeded: [Item]
    var ingredientsOwned: [Item]
    var time: Double
    var difficulty: String
    
    init(name: String, image: UIImage?, ingredientsNeeded: [Item], ingredientsOwned: [Item], time: Double, difficulty: String) {
        self.name = name
        self.image = image
        self.ingredientsNeeded = ingredientsNeeded
        self.ingredientsOwned = ingredientsOwned
        self.time = time
        self.difficulty = difficulty
    }
}



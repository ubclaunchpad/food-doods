//
//  Item.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2019-10-31.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit


struct Item {
    var name: String
    var image: UIImage?
    var location: FoodLocation
    var amount: Int
    
    init(name: String, image: UIImage?, location: FoodLocation, amount: Int) {
        self.name = name
        self.image = image
        self.location = location
        self.amount = amount
    }
}


enum FoodLocation {
    case all
    case pantry
    case fridge
    case dry
}

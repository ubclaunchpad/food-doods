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
    
    init(name: String, image: UIImage?, location: FoodLocation) {
        self.name = name
        self.image = image
        self.location = location
    }
}


enum FoodLocation {
    case all
    case pantry
    case fridge
    case dry
}

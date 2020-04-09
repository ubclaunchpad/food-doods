//
//  IngredientAPIModels.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-04-01.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation

// MARK: - UserIngredientsModel
struct UserIngredientsModel: Codable {
    let id: String
    let ingredients: [IngredientModel]
}

// MARK: - Ingredient
struct IngredientModel: Codable {
    let id: Int
    let name, quantity, unit: String
}

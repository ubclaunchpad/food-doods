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
    let userID: String
    let ingredients: [IngredientModel]

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case ingredients
    }
}

// MARK: - Ingredient
struct IngredientModel: Codable {
    let userID, ingredientID: Int
    let quantity: String
    let id: Int
    let name: String
    let testData: Bool
    let unitCategory: Int

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case ingredientID = "ingredient_id"
        case quantity, id, name
        case testData = "test_data"
        case unitCategory = "unit_category"
    }
}

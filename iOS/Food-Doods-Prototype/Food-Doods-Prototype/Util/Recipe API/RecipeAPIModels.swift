//
//  RecipeAPIModels.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-03-30.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation

// MARK: - RecipeModel
struct RecipeModel: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let ingredients: [RecipeIngredient]
    let instructions: [String]
    let id, name: String
    let time: RecipeTime
    let servings: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case ingredients, instructions
        case id = "_id"
        case name, time, servings
        case v = "__v"
    }
}

// MARK: - RecipeIngredient
struct RecipeIngredient: Codable {
    let id, unitCategory: Int
    let unit: String?
    let quantity: Double
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case unitCategory = "unit_category"
        case unit, quantity, name
    }
}

// MARK: - RecipeTime
struct RecipeTime: Codable {
    let id, prep, cook, active: String
    let inactive, ready, total: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case prep, cook, active, inactive, ready, total
    }
}

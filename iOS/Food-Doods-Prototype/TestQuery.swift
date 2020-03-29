//
//  TestQuery.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-02-08.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation

// MARK: - REQUEST DATA STRUCTURES

//MARK: TestQuery
struct TestQuery: Codable {
    let userID: String
    let queryIngredients: [QueryIngredient]
}

// MARK: QueryIngredient
struct QueryIngredient: Codable {
    let commonName, databaseID: String
}

// MARK: IngredientUser
struct IngredientUserMode: Codable {
    let externalId: String
}

// MARK: - RESPONSE DATA STRUCTURES
struct ResponseHashes: Codable {
    let hashes: [Int]
}


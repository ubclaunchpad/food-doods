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

//MARK: TestCreateUserModel
struct CreateUserModel: Codable {
    let email, username, password, fullName: String
}



// MARK: - RESPONSE DATA STRUCTURES
struct ResponseHashes: Codable {
    let hashes: [Int]
}


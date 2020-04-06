//
//  UserAPIModels.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-03-30.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation

// MARK: - Data Models for Decoding User Endpoint API Calls

struct CreateNewUserModel: Codable {
    let email, username, password, fullName: String
}

struct LoginUserModel: Codable {
    let username, password: String
}

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let message: String
}

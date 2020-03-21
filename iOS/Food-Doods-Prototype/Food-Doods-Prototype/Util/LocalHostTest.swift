//
//  LocalHostTest.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-02-08.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation

enum Service {
    case Suggestion
    case User
    case Ingredient
    case Recipe
}

class LocalHostTest {
    var baseURL: String
    
    static let shared = LocalHostTest("http://localhost:8000")
    
    private init (_ hostName: String) {
        baseURL = hostName
    }
    
    public func getIngredientsList() {
        guard let requestURL = createEndpointURL(for: Service.Ingredient, url: baseURL) else { return }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    if let response = response {
                        print("--- Response ---")
                        print(response)
                    }
                    
                    if let data = data {
                        print ("--- Data ---")
                        
                        //MARK: Decode Data
    //                let decodedData = try? JSONDecoder().decode(ResponseHashes.self, from: data)
    //                guard let data = decodedData else {
    //                    print("Could not decode data")
    //                    return
    //                }
                        
                        print(data)
                    }
        }
                
        dataTask.resume()
    }
    
    public func createUser() {
        guard let requestURL = createEndpointURL(for: Service.User, url: baseURL) else { return }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = createUserHelper()
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error {
                print("--- Error ---")
                print(error)
                return
            }
            
            if let response = response {
                print("--- Response ---")
                print(response)
            }
            
            if let data = data {
                print ("--- Data ---")
                print(data)
            }
        }
        
        dataTask.resume()
    }
    
    private func createUserHelper() -> Data? {
        let body = CreateUserModel(email: "hello@gmail.com", username: "testUser", password: "password", fullName: "Joe Mama")
        
        let encoded = try? JSONEncoder().encode(body)
        
        return encoded
    }
    
    public func getUser() {
        guard let requestURL = createEndpointURL(for: Service.User, url: baseURL) else { return }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let response = response {
                print("--- Response ---")
                print(response)
            }
            
            if let data = data {
                print ("--- Data ---")
                
                //MARK: Decode Data
//                let decodedData = try? JSONDecoder().decode(ResponseHashes.self, from: data)
//                guard let data = decodedData else {
//                    print("Could not decode data")
//                    return
//                }
                

                print(data)
            }
        }
        
        dataTask.resume()
    }
    
    public func getRecipeSuggestions() {
        guard let requestURL = createEndpointURL(for: Service.Suggestion, url: baseURL) else { return }
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //MARK: ATTACH LIST OF INGREDIENTS TO JSON BODY
        let testIngredients: [QueryIngredient] = [
            QueryIngredient(commonName: "broccoli", databaseID: "1"),
            QueryIngredient(commonName: "beef", databaseID: "5"),
            QueryIngredient(commonName: "brown rice", databaseID: "7"),
            QueryIngredient(commonName: "garlic", databaseID: "13")
        ]
        
        request.httpBody = assembleJSON(testIngredients)
        
        
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let response = response {
                print("--- Response ---")
                print(response)
            }
            
            if let data = data {
                print ("--- Data ---")
                
                let decodedData = try? JSONDecoder().decode(ResponseHashes.self, from: data)
                
                guard let data = decodedData else {
                    print("Could not decode data")
                    return
                }
                
                for i in 0..<data.hashes.count {
                    print("Hash #\(i): \(data.hashes[i])")
                }
                
                //MARK: Deal with hashes here
                //ie dispatch queue to update UI
            }
        }
        
        dataTask.resume()
    }
    
    private func assembleJSON(_ ingredients: [QueryIngredient]) -> Data? {
        
        
        let query = TestQuery(userID: "wrennyboy", queryIngredients: ingredients)
        
        let packagedQuery = try? JSONEncoder().encode(query)
        
        return packagedQuery
    }
    
    private func createEndpointURL(for service: Service, url: String) -> URL? {
        var returnURL = url
        
        switch (service) {
        case Service.Suggestion:
            returnURL.append("/suggestion")
            break
        case Service.User:
            returnURL.append("/user")
            break
            
        case Service.Ingredient:
            returnURL.append("/user/ingredient/1")
            break
        default:
            print("No special action needed")
        }
        
        return URL(string: returnURL)
    }
        
}



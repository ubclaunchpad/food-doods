//
//  LocalHostTest.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-02-08.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation


class LocalHostTest {
    var baseURL: String
    
    static let shared = LocalHostTest("http://localhost:8585/suggestion")
    
    private init (_ hostName: String) {
        baseURL = hostName
    }
    
    public func testCall() {
        var request = URLRequest(url: URL(string: baseURL)!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = assembleJSON()
        
        //MARK: ATTACH LIST OF INGREDIENTS TO JSON BODY
        
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
    
    private func assembleJSON() -> Data? {
        let testIngredients: [QueryIngredient] = [
            QueryIngredient(commonName: "broccoli", databaseID: "1"),
            QueryIngredient(commonName: "beef", databaseID: "5"),
            QueryIngredient(commonName: "brown rice", databaseID: "7"),
            QueryIngredient(commonName: "garlic", databaseID: "13")
        ]
        
        let query = TestQuery(userID: "wrennyboy", queryIngredients: testIngredients)
        
        let packagedQuery = try? JSONEncoder().encode(query)
        
        return packagedQuery
    }
}



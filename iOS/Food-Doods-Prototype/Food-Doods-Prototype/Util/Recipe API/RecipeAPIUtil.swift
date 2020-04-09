//
//  RecipeAPIUtil.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-03-30.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation

enum RecipeFunction {
    case GETrecipeByID
    case GETrecipesOfUser
}

enum RecipeError: Error {
    case missingID
}

class RecipeAPIUtil {
    var hostURL: String

    static let shared = RecipeAPIUtil("http://localhost:8080")

    private init (_ baseURL: String) {
        self.hostURL = baseURL
    }
    
    public func getRecipeBy(recipeID: String, completionHandler: @escaping (RecipeModel) -> Void) {
        do {
            let requestURL = try assembleURL(for: RecipeFunction.GETrecipeByID, recipeID: recipeID)
            
            var request = URLRequest(url: URL(string: requestURL)!)
            
            request.httpMethod = "GET"
            
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
                    let str = String(decoding: data, as: UTF8.self)
                    
                    print(str)
                    
                    DispatchQueue.main.async {
                        do {
                            let decodedData = try JSONDecoder().decode(RecipeModel.self, from: data)
                            print("*** DECODED ***")
                            completionHandler(decodedData)
                        } catch {
                            print(error)
                        }
                        
                    }
                }
            }
            
            dataTask.resume()
        } catch (UserError.missingUsername) {
            print("Error: Missing username")
        } catch {
            print("Unknown Error")
        }
        
        
    }
    
    private func assembleURL(for function: RecipeFunction, recipeID: String? = nil, userID: String? = nil) throws -> String {
        var url = hostURL

        switch (function) {
        case RecipeFunction.GETrecipeByID:
            guard let id = recipeID else { throw RecipeError.missingID }
            url.append("/recipe/recipe/\(id)")
            break
        case RecipeFunction.GETrecipesOfUser:
            guard let id = userID else { throw RecipeError.missingID }
            url.append("/recipe/user/\(id)")
            break
        }

        return url
    }
    
}

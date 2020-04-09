//
//  IngredientAPIUtil.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-04-01.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation

enum IngredientFunction {
    case GETusersIngred
}

enum IngredientError: Error {
    case missingID
}

class IngredientAPIUtil {
    var hostURL: String

    static let shared = IngredientAPIUtil("http://localhost:9000")

    private init (_ baseURL: String) {
        self.hostURL = baseURL
    }
    
    public func getUserIngredientList(userID: String, completionHandler: @escaping (UserIngredientsModel) -> Void) {
        do {
            let requestURL = try assembleURL(for: IngredientFunction.GETusersIngred, userID: userID)
            
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
                            let decodedData = try JSONDecoder().decode(UserIngredientsModel.self, from: data)
                            
                            print(decodedData)
                            
                            completionHandler(decodedData)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            
            dataTask.resume()
            
        } catch IngredientError.missingID {
            print("Error: Missing user ID")
        } catch {
            print("Unknown error")
        }
    }
    
    
    private func assembleURL(for function: IngredientFunction, userID: String? = nil) throws -> String {
        var url = hostURL
        
        switch (function) {
        case IngredientFunction.GETusersIngred:
            guard let id = userID else { throw IngredientError.missingID }
            url.append("/user/ingredient/\(id)")
            break
        }
        
        return url
    }
    
    

}

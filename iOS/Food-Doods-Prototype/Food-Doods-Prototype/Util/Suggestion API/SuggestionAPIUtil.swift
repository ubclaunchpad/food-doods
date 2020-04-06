
//
//  SuggestionAPIUtil.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-04-06.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation

enum SuggestionFunction {
    case POSTfetchByUserID
}

enum SuggestionError: Error {
    case missingUserID
}


class SuggestionAPIUtil {
    var hostURL: String
    
    static let shared = SuggestionAPIUtil("http://localhost:8585")
    
    private init (_ baseURL: String) {
        self.hostURL = baseURL
    }
    
    public func suggestRecipesBy(userID: String) {
        do {
            let requestURL = try assembleURL(for: SuggestionFunction.POSTfetchByUserID)
            
            var request = URLRequest(url: URL(string: requestURL)!)
            
            request.httpMethod = "POST"
            
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
                        let decodedData = try? JSONDecoder().decode(SuggestionModel.self, from: data)
                        
                        
                    }
                }
            }
            
            dataTask.resume()
            
        } catch SuggestionError.missingUserID {
            print("Error: Missing user ID")
        } catch {
            print("Unknown Error")
        }
    }
    
    
    private func assembleURL(for function: SuggestionFunction, userID: String? = nil) throws -> String {
        var url = hostURL
        
        switch (function) {
        case SuggestionFunction.POSTfetchByUserID:
            guard let id = userID else { throw SuggestionError.missingUserID }
            url.append("/suggestion/\(id)")
            break
        }
        
        return url
    }
    
}

//
//  UserAPIUtil.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-03-29.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation

enum UserFunction {
    case GETuser
    case POSTcreateUser
    case POSTloginUser
}

enum UserError: Error {
    case missingUsername
}

class UserAPIUtil {
    var hostURL: String
    
    static let shared = UserAPIUtil("http://localhost:8000")
    
    private init (_ baseURL: String) {
        self.hostURL = baseURL
    }
    
    public func getUser(with username: String, token: String) {
        do {
            let requestURL = try assembleURL(for: UserFunction.GETuser, username: username)
            
            var request = URLRequest(url: URL(string: requestURL)!)
            
            request.httpMethod = "GET"
            request.addValue(token, forHTTPHeaderField: "token")
            
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
                }
            }
            
            dataTask.resume()
        } catch (UserError.missingUsername) {
            print("Error: Missing username")
        } catch {
            print("Unknown Error")
        }
        
    }
    
    public func createNewUser(email: String, username: String, password: String, fullName: String) {
        do {
            let requestURL = try assembleURL(for: UserFunction.POSTcreateUser)
            
            var request = URLRequest(url: URL(string: requestURL)!)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = createNewUserJSON(email: email, username: username, password: password, fullName: fullName)
            
            let dataTask = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if let error = error {
                    print("--- Error ---")
                    print(error)
                    return
                }
                if let response = response as? HTTPURLResponse {
                    print("--- Response ---")
                    print(response)
                    
                    if let token = response.allHeaderFields["token"] as? String {
                        print("Setting token as: \(token)")
                        UserDefaults.standard.set(token, forKey: "token")
                    }
                }
                if let data = data {
                    print ("--- Data ---")
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
                }
            }
            
            dataTask.resume()
        } catch (UserError.missingUsername) {
            print("Error: Missing username")
        } catch {
            print("Unknown Error")
        }
    }
    private func createNewUserJSON(email: String, username: String, password: String, fullName: String) -> Data? {
        let structure = CreateNewUserModel(email: email, username: username, password: password, fullName: fullName)
        let json = try? JSONEncoder().encode(structure)
        return json
    }
    
    public func loginUser(username: String, password: String, token: String, completion: @escaping (Bool) -> Void) {
        do {
            let requestURL = try assembleURL(for: UserFunction.POSTloginUser)
            
            var request = URLRequest(url: URL(string: requestURL)!)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(token, forHTTPHeaderField: "token")
            request.httpBody = loginUserJSON(username: username, password: password)
            
            let dataTask = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if let error = error {
                    print("--- Error ---")
                    print(error)
                    
                    completion(false)
                    
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
                            let decodedData = try JSONDecoder().decode(LoginResponse.self, from: data)
                            
                            if decodedData.message == "Successfully logged in." {
                                completion(true)
                            } else {
                                completion(false)
                            }
                            
                        } catch {
                            print(error)
                            completion(false)
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
    private func loginUserJSON(username: String, password: String) -> Data? {
        let structure = LoginUserModel(username: username, password: password)
        let json = try? JSONEncoder().encode(structure)
        return json
    }
    
    
    private func assembleURL(for function: UserFunction, username: String? = nil) throws -> String {
        var url = hostURL
        
        switch (function) {
        case UserFunction.GETuser:
            guard let username = username else { throw UserError.missingUsername }
            url.append("/user/\(username)")
            break
        case UserFunction.POSTcreateUser:
            url.append("/user")
            break
        case UserFunction.POSTloginUser:
            url.append("/user/login")
            break
        }
        
        return url
    }
}

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
    
    static let shared = LocalHostTest("http://localhost:6000/")
    
    private init (_ hostName: String) {
        baseURL = hostName
    }
    
    public func testCall() {
        var request = URLRequest(url: URL(string: baseURL)!)
        
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            print(response)
        }
        
        dataTask.resume()
        
    }
}



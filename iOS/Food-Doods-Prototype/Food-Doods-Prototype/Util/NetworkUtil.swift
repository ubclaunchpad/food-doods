//
//  NetworkUtil.swift
//  Food-Doods-Prototype
//
//  Created by Wren Liang on 2020-02-08.
//  Copyright © 2020 Wren Liang. All rights reserved.
//

import Foundation

class NetworkUtil {
    var baseURL: String
    
    static let shared = NetworkUtil("http://localhost:6000/")
    
    private init (_ hostName: String) {
        baseURL = hostName
    }
}

//
//  User.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

struct User: Codable {
    let email: String
    let firstName: String
    let lastName: String
    let store: Store
    var password: String?
    var token: String?
    
    mutating func setToken(token: String){
        self.token = token
    }
    
}
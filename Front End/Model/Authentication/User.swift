//
//  User.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

struct User: Codable{
    let email: String
    let firstname: String?
    let lastname: String?
    let password: String
}

struct LoginResponse: Codable{
    let token: String
}

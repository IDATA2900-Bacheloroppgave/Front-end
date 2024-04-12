//
//  User.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

struct User: Identifiable, Codable{
    let id: String
    let email: String
    let password: String
}

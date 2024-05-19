//
//  User.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import Foundation

// A struct representing a User
struct User: Codable {
    let email: String
    let firstName: String
    let lastName: String
    let store: Store
}

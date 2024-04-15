//
//  Store.swift
//  Front End
//
//  Created by Siri Sandnes on 15/04/2024.
//

import Foundation

struct Store: Codable {
    let name: String
    let address: String
    let country: String
    let city: String
    let postalCode: Int
}

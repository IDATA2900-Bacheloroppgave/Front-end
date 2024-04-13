//
//  Products.swift
//  Front End
//
//  Created by Siri Sandnes on 13/04/2024.
//

import Foundation

struct Product: Codable {
    var productId: Int
    var name, description, supplier: String
    var bestBeforeDate: String
    var productType: String
    var price: Double
    var gtin: Int
    var batch: Int
    var inventory: Inventory?
    var packaging: Packaging
    
    mutating func setInventory(inventory: Inventory){
        self.inventory = inventory
    }
    
    mutating func setPackaging(packaging: Packaging){
        self.packaging = packaging
    }
}

struct Inventory: Codable {
    var totalStock, reservedStock, availableStock: Int
}

struct Packaging: Codable {
    var packageType: String
    var quantityPrPackage, weightInGrams: Int
    var dimensionInCm3: Double
}



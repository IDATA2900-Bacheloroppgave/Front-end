//
//  Products.swift
//  Front End
//
//  Created by Siri Sandnes on 13/04/2024.
//

import Foundation
import SwiftUI

struct Product: Codable {
    var productId: Int
    var name: String
    var description: String
    var supplier: String
    var bestBeforeDate: String
    var productType: String
    var price: Double
    var gtin: Int
    var batch: Int
    var inventory: Inventory
    var packaging: Packaging
    
    mutating func setInventory(inventory: Inventory){
        self.inventory = inventory
    }
    
    mutating func setPackaging(packaging: Packaging){
        self.packaging = packaging
    }
    
    func getProductColor() -> Color{
        var color = Color.dryGoods
        if self.productType == "REFRIGERATED_GOODS" {
            color = Color.iconVeggie
        } else if self.productType == "FROZEN_GOODS" {
            color = Color.freezedGoods
        }
        return color
    }
}

struct ProductQuantity: Codable{
    var productQuantity: Int
    var product: Product
}

struct Inventory: Codable {
    var totalStock, reservedStock, availableStock: Int
}

struct Packaging: Codable {
    var packageType: String
    var quantityPrPackage: Int
    var weightInGrams: Int
    var dimensionInCm3: Double
}




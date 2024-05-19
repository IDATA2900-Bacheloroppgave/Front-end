//
//  Products.swift
//  Front End
//
//  Created by Siri Sandnes on 13/04/2024.
//

import Foundation
import SwiftUI

/**
 A struct representing a Product
 */
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
    
    /**
     Returns the correct color associated with productType
     */
    func getProductColor() -> Color{
        var color = Color.solwrYellow
        if self.productType == "REFRIGERATED_GOODS" {
            color = Color.solwrGreen
        } else if self.productType == "FROZEN_GOODS" {
            color = Color.solwrLightBlue
        }
        return color
    }
}

/**
 A struct representing ProductQuantity
 */
struct ProductQuantity: Codable{
    var productQuantity: Int
    var product: Product
}

/**
 A struct represenitning Inventoy
 */
struct Inventory: Codable {
    var totalStock, reservedStock, availableStock: Int
}

/**
 A struct represenitning Packaging
 */
struct Packaging: Codable {
    var packageType: String
    var quantityPrPackage: Int
    var weightInGrams: Int
    var dimensionInCm3: Double
}




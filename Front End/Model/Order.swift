//
//  Order.swift
//  Front End
//
//  Created by Siri Sandnes on 18/04/2024.
//

import Foundation

struct Order: Codable{
    var orderId: Int
    var orderDate: String
    var orderStatus: String
    var wishedDeliveryDate: String
    var progressInPercent: Double
    var customer: User
    var quantities: [Quantity]
}


struct Quantity: Codable{
    var productQuantity: Int
    var product: Product
}

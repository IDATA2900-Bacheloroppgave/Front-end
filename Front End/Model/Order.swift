//
//  Order.swift
//  Front End
//
//  Created by Siri Sandnes on 18/04/2024.
//

import Foundation

/**
 A struct representing an Order
 */
class Order: Identifiable, Codable {
    var orderId: Int
    var orderDate: String
    var orderStatus: String
    var wishedDeliveryDate: String
    var progressInPercent: Double
    var customer: User
    var quantities: [Quantity]
    var currentLocation: String?
    var orderDateAsDate: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           return dateFormatter.date(from: orderDate)
       }

    init(orderId: Int, orderDate: String, orderStatus: String, wishedDeliveryDate: String, progressInPercent: Double, customer: User, quantities: [Quantity]) {
        self.orderId = orderId
        self.orderDate = orderDate
        self.orderStatus = orderStatus
        self.wishedDeliveryDate = wishedDeliveryDate
        self.progressInPercent = progressInPercent
        self.customer = customer
        self.quantities = quantities
    }
    
    /**
     Sets the current location of the order
     */
    func setCurrentLocation(location: String){
        self.currentLocation = location
    }
}

/**
 A struct representing Quantity
 */
struct Quantity: Identifiable, Codable {
    var id: Int { product.productId }
    var productQuantity: Int
    var product: Product
}

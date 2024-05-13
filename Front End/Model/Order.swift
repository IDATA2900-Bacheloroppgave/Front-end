//
//  Order.swift
//  Front End
//
//  Created by Siri Sandnes on 18/04/2024.
//

import Foundation


class Order: Identifiable, Codable {
    var orderId: Int
    var orderDate: String
    var orderStatus: String
    var wishedDeliveryDate: String
    var progressInPercent: Double
    var customer: User
    var quantities: [Quantity]
    var currentLocation: String? // Add currentLocation property
    var orderDateAsDate: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust the date format according to your string
           return dateFormatter.date(from: orderDate)
       }

    init(orderId: Int, orderDate: String, orderStatus: String, wishedDeliveryDate: String, progressInPercent: Double, customer: User, quantities: [Quantity]) {
        self.orderId = orderId
        self.orderDate = orderDate
        self.orderStatus = orderStatus
        self.wishedDeliveryDate = wishedDeliveryDate
        self.progressInPercent = progressInPercent
        self.customer = customer
        self.quantities = quantities// Initialize currentLocation property
    }
    
    func setCurrentLocation(location: String){
        self.currentLocation = location
    }
}


struct Quantity: Identifiable, Codable {
    var id: Int { product.productId } // Using product's ID as Quantity's ID for uniqueness
    var productQuantity: Int
    var product: Product
}

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
    
    var orderDateAsDate: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust the date format according to your string
           return dateFormatter.date(from: orderDate)
       }
}


struct Quantity: Codable{
    var productQuantity: Int
    var product: Product
}

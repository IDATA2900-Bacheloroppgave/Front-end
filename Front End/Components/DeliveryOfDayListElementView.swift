//
//  DeliveryOfDayListElementView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI

struct DeliveryOfDayListElementView: View {
    let deliveryItem: DeliveryItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(deliveryItem.title)
                    .font(.headline)
                Text("#\(deliveryItem.id)")
                    .font(.caption)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(deliveryItem.company)
                    .font(.headline)
                Text("Products: \(deliveryItem.productsCount)")
                    .font(.caption)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.06, green: 0.44, blue: 0.53), lineWidth: 1))
      
    }
}

#Preview {
    DeliveryOfDayListElementView(deliveryItem: DeliveryItem(id: "test", title: "test", company: "test", productsCount: 3))
}

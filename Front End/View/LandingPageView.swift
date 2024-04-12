//
//  LandingPageView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI

struct LandingPageView: View {
    
    let deliveryItems: [DeliveryItem] = [
            DeliveryItem(id: "1589284", title: "Ferskvarer", company: "Gjørts AS", productsCount: 30),
            DeliveryItem(id: "1589284", title: "Ferskvarer", company: "Gjørts AS", productsCount: 30),
            DeliveryItem(id: "1589284", title: "Ferskvarer", company: "Gjørts AS", productsCount: 30)
            // Add more items as needed
        ]
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(red: 0.96, green: 0.96, blue: 0.96)
                VStack{
                    Text("Deliveries of the day").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).padding(.horizontal)
                    ScrollView{
                        VStack(spacing: 8) {
                                        ForEach(deliveryItems) { item in
                                            DeliveryItemView(deliveryItem: item)
                                        }
                                    }
                                    .padding()
                    }
                    ScanToOrderBtn()
                }
            }
            
        }
        
       
    }
}


#Preview {
    LandingPageView()
}

struct DeliveryItem: Identifiable {
    let id: String
    let title: String
    let company: String
    let productsCount: Int
}

struct DeliveryItemView: View {
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




struct ScanToOrderBtn: View {
    var body: some View {
        Button(action: {
            // Action for the button tap
        }) {
            HStack {
                Text("Scan to order")
                    .font(.system(size: 25, weight: .medium)) // Adjust font size and weight as needed
                    .foregroundColor(Color.black)
                
                Spacer() // This will push the text and the icon to opposite sides
                
                Image(systemName: "barcode.viewfinder")
                    .foregroundColor(.black)
                    .font(.system(size: 50)) // Adjust icon size as needed
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20) // Adjust padding as needed
            .background(Color.yellow) // Use the color that matches your design
            .cornerRadius(10) // Adjust corner radius to match your design
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
    }
}

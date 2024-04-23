//
//  UpcomingDeliveryCardView.swift
//  SolwrTest
//
//  Created by Ina Folland Hegg on 16/04/2024.
//

import SwiftUI

struct ActiveOrderCardView: View {
    
    let orderNumber: String
    let productsInOrder: Int
    let status: String
    let estimatedDelivery: String
    let progressValue: Double
    
    
    var body: some View {
        
        VStack {
            HStack{
                Image(systemName: "truck.box.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor( Color(red: 1.00, green: 0.83, blue: 0.00))
                
                Text("#\(orderNumber)")
                    .fontWeight(.medium)
                    .font(.subheadline)
                
                Spacer()
                
                Text(String("Products: \(productsInOrder)"))
                    .font(.footnote)
                    .foregroundColor(.gray)
                
            }.padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 0))
            
            ProgressView(value: progressValue)
                .tint(.yellow)
                .scaleEffect(x: 1, y: 2.5)
            
            HStack{
                VStack (alignment: .leading){
                    Text("Status: \(status)")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Text("Requested delivery: \(estimatedDelivery)")
                        .foregroundColor(.bluePicker)
                        .font(.footnote)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(EdgeInsets(top: 8, leading: 2, bottom: 5, trailing: 0))
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .padding(.horizontal)
        .shadow(radius: 1)
    }
}

#Preview {
    ActiveOrderCardView(orderNumber: "#12345", productsInOrder: 1, status: "Skodje", estimatedDelivery: "Tomorrow before noon", progressValue: 0.1)
}

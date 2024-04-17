//
//  UpcomingDeliveryCardView.swift
//  SolwrTest
//
//  Created by Ina Folland Hegg on 16/04/2024.
//

import SwiftUI

struct UpcomingDeliveryView: View {
    
    let orderNumber: String
    let supplierName: String
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
                
                Text(orderNumber)
                    .fontWeight(.semibold)
                    .font(.subheadline)
                
                Spacer()
                
                Text(supplierName)
                    .font(.footnote)
                    .foregroundColor(.gray)
                
            }
            
            ProgressView(value: progressValue)
                .tint(.yellow)
                .frame(width: 340, height: 20)
                .scaleEffect(x: 1, y: 2)
            
            HStack{
                VStack (alignment: .leading){
                    Text("STATUS: \(status)")
                        .foregroundColor(.gray)
                        .font(.footnote)
                    Text("Estimated delivery: \(estimatedDelivery)")
                        .foregroundColor(.bluePicker)
                        .font(.footnote)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal)
        .shadow(radius: 2)
    }
}

#Preview {
    UpcomingDeliveryView(orderNumber: "#12345", supplierName: "Gjørts AS", status: "Skodje", estimatedDelivery: "Tomorrow before noon", progressValue: 0.1)
}

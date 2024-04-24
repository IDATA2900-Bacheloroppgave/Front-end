//
//  DeliveryCardView.swift
//  SolwrTest
//
//  Created by Ina Folland Hegg on 16/04/2024.
//


import SwiftUI

struct DeliveryCardView: View {
    let mainTitle: String
    let orderNumber: String
    let progressValue: Double
    let currentLocation: String
    let arrivalTime: String
    let supplierName: String

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(mainTitle)
                        .font(.headline)
                        .foregroundColor(.bluePicker)
                    Text(orderNumber)
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
                Spacer()
                Text(supplierName) // This can also be made dynamic if needed
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            
            ProgressView(value: progressValue)
                .tint(.yellow)
                .frame(width: 340)
                .padding(.vertical, 4) // Adjust padding as needed
                .scaleEffect(x: 1, y: 2.5)
                
            
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "location.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                        .foregroundColor(.bluePicker)
                    Text(currentLocation).font(.system(size: 14))
                }
                
                VStack {
                    Text(arrivalTime)
                        .font(.system(size: 14))
                        .foregroundColor(.bluePicker)
                        
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal)
        .shadow(radius: 1)
    }
}

#Preview {
    DeliveryCardView(mainTitle: "Frysevarer", orderNumber: "#12345", progressValue: 0.5, currentLocation: "Current location: Skodje", arrivalTime: "Arriving today between 12-2 pm", supplierName: "Gjørts AS")
}

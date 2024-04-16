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
                        .foregroundColor(.black)
                    Text(orderNumber)
                        .foregroundColor(.gray)
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
                .scaleEffect(x: 1, y: 2)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                    Text(currentLocation)
                }
                
                VStack {
                    Text(arrivalTime)
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal)
        .shadow(radius: 2)
    }
}

#Preview {
    DeliveryCardView(mainTitle: "Frysevarer", orderNumber: "#12345", progressValue: 0.5, currentLocation: "Current location: Skodje", arrivalTime: "Arriving today between 12-2 pm", supplierName: "Gjørts AS")
}

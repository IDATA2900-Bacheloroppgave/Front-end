//
//  ProductInfoCardView.swift
//  SolwrTest
//
//  Created by Ina Folland Hegg on 16/04/2024.
//
import SwiftUI

struct ProductInfoCard: View {
    
    let productName: String
    let productIcon: String
    let supplierName: String
    let batchNumber: Int
    let bestBeforeDate: String
    let quantityInfo: String
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: productIcon)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                    VStack (alignment: .leading) {
                        Text(productName)
                            .font(.headline)
                        .foregroundColor(.black)
                        
                        Text(supplierName)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("Batch: \(batchNumber)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("Best before: \(bestBeforeDate)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.all)

            Spacer()
            
            VStack {
                Text(quantityInfo)
                    .font(.body)
                    .bold()
                    .foregroundColor(.black)
                    .padding() // Adds padding on top and bottom
            }
            .background(Color.yellow.opacity(0.5))
            .cornerRadius(5)
            .padding()
            
        }
        .frame(height: 100) // Set the frame height of the entire HStack to enforce the card height.
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

#Preview {
    ProductInfoCard(productName: "Speltrundstykker", productIcon: "fork.knife.circle.fill", supplierName: "Hatting", batchNumber: 123, bestBeforeDate: "17.02.25", quantityInfo: "5 D-pak")
}

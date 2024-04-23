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
    let quantityInfo: Int
    
    
    var body: some View {
        HStack{
            HStack(spacing: 4) {
                Image(systemName: productIcon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.iconVeggie)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 0))
                VStack(alignment: .leading, spacing: 2){
                    Text(productName)
                        .foregroundStyle(.bluePicker)
                        .fontWeight(.medium)
                    Text(supplierName)
                        .font(.system(size: 14))
                    VStack(alignment: .leading){
                        Text("Batch: \(batchNumber)")
                            .foregroundStyle(.greyText)
                            .font(.system(size: 12))
                        Text("Best before: \(bestBeforeDate)")
                            .foregroundStyle(.greyText)
                            .font(.system(size: 12))
                    }
                }
                .frame(maxWidth: .infinity , alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            }
            Spacer() // Add Spacer to push "5-Dpak" to the end
            Text(String("\(quantityInfo) D-Pk"))
                .font(.system(size: 14))
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                .frame(maxWidth: 100, maxHeight: .infinity, alignment: .center)
                .background(.accent .opacity(0.4))
        }
        .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 1)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .padding(.horizontal)
    }
    
}

#Preview {
    ProductInfoCard(productName: "Speltrundstykker", productIcon: "fork.knife.circle.fill", supplierName: "Hatting", batchNumber: 123, bestBeforeDate: "17.02.25", quantityInfo: 5)
}

//
//  ProductInfoCardView.swift
//  SolwrTest
//
//  Created by Ina Folland Hegg on 16/04/2024.
//
import SwiftUI

struct ProductInfoCard: View {
    
    let product : Product
    let amount : Int
    
    
    var body: some View {
        HStack{
            HStack(spacing: 4) {
                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(product.getProductColor())
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 0))
                VStack(alignment: .leading, spacing: 2){
                    Text(product.name)
                        .foregroundStyle(.bluePicker)
                        .fontWeight(.medium)
                    Text(product.supplier)
                        .font(.system(size: 14))
                    VStack(alignment: .leading){
                        Text("Batch: \(String(product.batch))")
                            .foregroundStyle(.greyText)
                            .font(.system(size: 12))
                        Text("Best before: \(product.bestBeforeDate)")
                            .foregroundStyle(.greyText)
                            .font(.system(size: 12))
                    }
                }
                .frame(maxWidth: .infinity , alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            }
            Spacer() 
            Text(String("\(amount) D-Pk"))
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
    
    
    func setColor() -> Color {
        var color = Color.dryGoods
        if self.product.productType == "REFRIGERATED_GOODS" {
            color = Color.iconVeggie
        } else if self.product.productType == "FROZEN_GOODS" {
            color = Color.freezedGoods
        }
        return color
    }
    
}

#Preview {
    ProductInfoCard(product: Product(productId: 12, name: "", description: "", supplier: "", bestBeforeDate: "", productType: "", price: 21, gtin: 12, batch: 12, inventory: Inventory(totalStock: 12, reservedStock: 12, availableStock: 12), packaging: Packaging(packageType: "", quantityPrPackage: 12, weightInGrams: 12, dimensionInCm3: 12)), amount: 2)
}

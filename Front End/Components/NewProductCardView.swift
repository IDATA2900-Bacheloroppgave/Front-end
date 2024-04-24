//
//  NewProductCardView.swift
//  Front End
//
//  Created by Siri Sandnes on 24/04/2024.
//

import SwiftUI

struct NewProductCardView: View {
    @Binding var amount : Int
    let productIcon: String
    let product: Product
    
    
    
    var body: some View {
        HStack{
            NavigationStack {
                NavigationLink{
                    ProductView(
                        productName: product.name,
                        supplier: product.supplier,
                        currentStock: product.inventory?.availableStock ?? 0,
                        productType: product.productType,
                        packaging: product.packaging?.packageType ?? "", contentPerPackage: product.packaging?.quantityPrPackage ?? 0,
                        price: product.price,
                        weight: Double(product.packaging?.weightInGrams ?? Int(0.0)), gtin: product.gtin,
                        batch: product.batch,
                        bestBefore: product.bestBeforeDate)
                }label: {
                    HStack(spacing: 4) {
                        Image(systemName: productIcon)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.iconVeggie)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 0))
                        VStack(alignment: .leading, spacing: 2){
                            Text(product.name)
                                .foregroundStyle(.bluePicker)
                                .fontWeight(.medium)
                            Text(product.supplier)
                                .font(.system(size: 14))
                            VStack(alignment: .leading){
                                Text("Batch: \(product.batch)")
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
                }
            }
            Spacer() // Add Spacer to push "5-Dpak" to the end
            VStack {
                Text("\(amount)")
                    .foregroundStyle(.bluePicker)
                Stepper("", value: $amount, in: 0...100)
                    .labelsHidden()
                
            }
            .frame(maxWidth: 100)
            .padding(.horizontal)
                
            
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
    NewProductCardView(amount: .constant(0), productIcon: "fork.knife.circle.fill", product: Product(productId: 12, name: "", description: "", supplier: "", bestBeforeDate: "", productType: "", price: 12, gtin: 12, batch: 12))
}

//
//  ConfirmOrderView.swift
//  Front End
//
//  Created by Ina Folland Hegg on 26/04/2024.
//

import SwiftUI

struct ConfirmOrderView: View {
    var order : Order
    init(order: Order) {
        self.order = order
    }
var body: some View {
    NavigationStack{
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.96)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack {
                    Text("Order Summary")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity) // Stretch the text to fill the entire width
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        .background(.accent)
                }
                VStack {
                    VStack {
                        Text("Products in order")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .padding()
                        ScrollView{
                            ForEach(order.quantities.indices, id: \.self) { index in
                                let quantity = order.quantities[index]
                                NavigationLink{
                                    ProductView(
                                        productName: quantity.product.name,
                                        supplier: quantity.product.supplier,
                                        currentStock: quantity.product.inventory?.availableStock ?? 0,
                                        productType: quantity.product.productType,
                                        packaging: quantity.product.packaging?.packageType ?? "", contentPerPackage: quantity.product.packaging?.quantityPrPackage ?? 0,
                                        price: quantity.product.price,
                                        weight: Double(quantity.product.packaging?.weightInGrams ?? Int(0.0)), gtin: quantity.product.gtin,
                                        batch: quantity.product.batch,
                                        bestBefore: quantity.product.bestBeforeDate)
                                }label: {
                                    ProductInfoCard(productName:quantity.product.name,
                                                    productIcon: "fork.knife.circle.fill",
                                                    supplierName: quantity.product.supplier,
                                                    batchNumber: quantity.product.batch,
                                                    bestBeforeDate: quantity.product.bestBeforeDate,
                                                    quantityInfo: quantity.productQuantity)
                                }
                            }
                            
                        }
                        Button(action: {
                            // Action for the button tap
                        }) {
                            HStack {
                                Text("Confirm Order")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color.black)
                                
                                Spacer() // This will push the text and the icon to opposite sides
                                
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.black)
                                    .font(.system(size: 35))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15) // Adjust padding as needed
                            .background(Color.iconVeggie)
                            .cornerRadius(10)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                    }
                    .padding(0)
                }
            }
        }.tint(.black)
    }
}
}


#Preview {
    ConfirmOrderView(order: Order(orderId: 1, orderDate: "", orderStatus: "", wishedDeliveryDate: "", progressInPercent: 0.8, customer: User(email: "", firstName: "", lastName: "", store: Store(name: "", address: "", country: "", city: "", postalCode: 1, storeId: 1)), quantities: [Quantity(productQuantity: 12, product: Product(productId: 1, name: "", description: "", supplier: "", bestBeforeDate: "", productType: "", price: 0.2, gtin: 1, batch: 1, packaging: Packaging(packageType: "", quantityPrPackage: 1, weightInGrams: 1, dimensionInCm3: 0.1)))]))
}

//
//  OrderInfoView.swift
//  SolwrTest
//
//  Created by Ina Folland Hegg on 16/04/2024.
//

import SwiftUI

struct OrderInfoView: View {
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
                        Text("Order #\(order.orderId)")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity) 
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                            .background(.accent)
                    }
                    VStack {
                        DeliveryCardView(
                            mainTitle: "Order: \(order.orderDate)",
                            orderNumber: "#\(order.orderId)",
                            progressValue: order.progressInPercent/100,
                            currentLocation: "Curent location: \(order.currentLocation ?? "Not available" )",
                            arrivalTime: "Requested delivery: \(order.wishedDeliveryDate)",
                            supplierName: "Gjørts AS").padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        VStack {
                            Text("Products in order")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                                .padding()
                            ScrollView{
                                ForEach(order.quantities) { quantity in
                                       NavigationLink {
                                           ProductView(
                                            product: quantity.product)
                                       } label: {
                                           ProductInfoCard(product: quantity.product, amount: getAmountOfProduct(product: quantity.product))
                                       }
                                   
                                   
                                }
                                
                            }
                        }
                        .padding(0)
                    }
                }
            }.tint(.black)
        }
    }
    
    func getAmountOfProduct(product: Product) -> Int{
        var amount = 0
        for quantity in order.quantities {
            if quantity.id == product.productId{
                amount = quantity.productQuantity
            }
        }
        return amount
    }
    
    
}

#Preview {
    OrderInfoView(order: Order(orderId: 1, orderDate: "", orderStatus: "", wishedDeliveryDate: "", progressInPercent: 0.8, customer: User(email: "", firstName: "", lastName: "", store: Store(name: "", address: "", country: "", city: "", postalCode: 1, storeId: 1)), quantities: [Quantity(productQuantity: 12, product: Product(productId: 1, name: "", description: "", supplier: "", bestBeforeDate: "", productType: "", price: 0.2, gtin: 1, batch: 1, inventory: Inventory(totalStock: 12, reservedStock: 12, availableStock: 12), packaging: Packaging(packageType: "", quantityPrPackage: 1, weightInGrams: 1, dimensionInCm3: 0.1)))]))
}


//
//  PastOrderCardView.swift
//  Front End
//
//  Created by Siri Sandnes on 17/04/2024.
//

import SwiftUI

struct PastOrderCardView: View {
    
    let order: Order
    
 
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "truck.box.fill")
                    
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.gray)
                
                Text(String("#\(order.orderId)"))
                    .fontWeight(.medium)
                    .font(.subheadline)
                Spacer()
                Text(String("Products: \(order.quantities.count)"))
                    .font(.footnote)
                    .foregroundStyle(Color(.solwrGreyText))
                
            }
            .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 0))
            
            ProgressView(value: order.progressInPercent/100)
                .tint(.solwrGreen)
                .scaleEffect(x: 1, y: 2.5)
            
            HStack{
                VStack (alignment: .leading){
                    Text("Status: \(order.orderStatus.prefix(1).uppercased() + order.orderStatus.dropFirst().lowercased())")
                        .foregroundStyle(Color(.solwrGreyText))
                        .font(.footnote)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(EdgeInsets(top: 8, leading: 2, bottom: 5, trailing: 0 ))
            
        }
        .padding()
        .background(.solwrCardBackground)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .padding(.horizontal)
        .shadow(radius: 1)
    }
}

#Preview {
    PastOrderCardView(order: Order(orderId: 12, orderDate: "", orderStatus: "", wishedDeliveryDate: "", progressInPercent: 12, customer: User(email: "", firstName: "", lastName: "", store: Store(name: "", address: "", country: "", city: "", postalCode: 12, storeId: 12)), quantities: [Quantity(productQuantity: 12, product: Product(productId: 12, name: "", description: "", supplier: "", bestBeforeDate: "", productType: "", price: 12, gtin: 21, batch: 12, inventory: Inventory(totalStock: 1, reservedStock: 1, availableStock: 1), packaging: Packaging(packageType: "", quantityPrPackage: 12, weightInGrams: 12, dimensionInCm3: 12)))]))
}

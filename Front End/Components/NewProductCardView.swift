//
//  NewProductCardView.swift
//  Front End
//
//  Created by Siri Sandnes on 24/04/2024.
//

import SwiftUI

struct NewProductCardView: View {
    var product: Product
    var itemAvailanle : Bool
    var availableQuantity : Int
    
    @State private var amount = 0
    @Binding var productAmounts: [Int: Int]
    @Binding var itemSelected : Bool
  
    
 
   
    
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
                        Image(systemName: "fork.knife.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(setColor())
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
            Spacer() 
            VStack {
                Text("\(amount) D-Pk")
                    .foregroundStyle(.bluePicker)
                Stepper("", value: $amount, in: 0...availableQuantity)
                    .labelsHidden()
                    .opacity(1.0)
                    .disabled(false)
                    .onChange(of: amount) { newValue, oldValue in
                                            // Update the product amount in the dictionary
                        productAmounts[product.productId] = newValue + 1
                        itemSelected = true //FIKS SÅ DEN KUN SETTES TIL TRUE NÅR DET ER 1 eller flere
                       
                    }
                
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
    
    func setColor () -> Color{
        var color = Color.dryGoods
        if self.product.productType == "REFRIGERATED_GOODS"{
            color = Color.iconVeggie
        }else if self.product.productType == "FREEZED_GOODS"{
            color = Color.freezedGoods
        }
        return color;
    }

}

#Preview {
    NewProductCardView(product: Product(productId: 12, name: "", description: "", supplier: "", bestBeforeDate: "", productType: "", price: 12, gtin: 12, batch: 12), itemAvailanle:true, availableQuantity: 2, productAmounts: .constant([1:1]), itemSelected: .constant(false))
}



//
//  ProductView.swift
//  Front End
//
//  Created by Siri Sandnes on 23/04/2024.
//

import SwiftUI

struct ProductView: View {
    let product: Product
    
    var body: some View {
        ZStack {
            Color(.solwrBackground)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack {
                    Text("Product info")
                        .foregroundStyle(.solwrMainTitle)
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        .background(.solwrMainTitleBackground)
                }
                VStack{
                    ScrollView{
                        HStack{
                            VStack{
                               
                                HStack{
                                    Image(systemName: "fork.knife.circle.fill") // Set this to be dynamic
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(product.getProductColor())
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                    
                                    VStack(spacing: 5, content: {
                                        TextInfoField(type: "Name:", text: product.name)
                                        TextInfoField(type: "Supplier:", text: product.supplier)
                                        TextInfoField(type: "Stock:", text: String(product.inventory.availableStock))
                                    
                                    })
                                    .padding()
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                              
                                }
                                .padding(.horizontal)
                                Divider()
                                    .padding(.horizontal)
                                VStack(spacing: 5, content: {
                                    TextInfoField(type: "Product type:", text: product.productType)
                                    TextInfoField(type: "Packaging:", text: product.packaging.packageType )
                                    TextInfoField(type: "Quantity:", text: String(product.packaging.quantityPrPackage))
                                    TextInfoField(type: "Price:", text: String(product.price))
                                    TextInfoField(type: "Weight:", text: "\(product.packaging.weightInGrams) g")
                                
                                })
                                .padding(.vertical)
                                .padding(.horizontal)
                                Divider()
                                    .padding(.horizontal)
                                VStack(spacing: 5, content: {
                                    TextInfoField(type: "GTIN:", text: String(product.gtin))
                                    TextInfoField(type: "Batch:", text: String(product.batch) )
                                    TextInfoField(type: "Best before:", text: product.bestBeforeDate)
                                   
                                
                                })
                                .padding(.vertical)
                                .padding(.horizontal)
                                
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(.solwrCardBackground)
                        .cornerRadius(5)
                        .padding(.horizontal)
                        .shadow(radius: 1)
                        
                    }
                }
                
            }
        }
    }
}

#Preview {
    ProductView(product: Product(productId: 12, name: "", description: "", supplier: "", bestBeforeDate: "", productType: "", price: 12, gtin: 12, batch: 12, inventory: Inventory(totalStock: 12, reservedStock: 12, availableStock: 12), packaging: Packaging(packageType: "", quantityPrPackage: 12, weightInGrams: 12, dimensionInCm3: 12)))
}

struct TextInfoField: View {
    let type: String
    let text: String
    var body: some View {
        HStack{
            Text("\(type)")
                .fontWeight(.medium)
                .font(.system(size: 17))
            
            Text("\(text)")
                .font(.system(size: 16))
                .foregroundStyle(.solwrDarkGrey)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        }
    }
}

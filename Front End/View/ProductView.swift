//
//  ProductView.swift
//  Front End
//
//  Created by Siri Sandnes on 23/04/2024.
//

import SwiftUI

struct ProductView: View {
    let productName: String
    let supplier: String
    let currentStock: Int
    let productType: String
    let packaging: String
    let contentPerPackage: Int
    let price: Double
    let weight: Double
    let gtin: Int
    let batch: Int
    let bestBefore: String
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.96)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack {
                    Text("Product info")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity) // Stretch the text to fill the entire width
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        .background(.accent)
                }
                VStack{
                    ScrollView{
                        HStack{
                            VStack{
                               
                                HStack{
                                    Image(systemName: "fork.knife.circle.fill") //Set this to be dynamic
                                        .resizable() // Make the image resizable
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.iconVeggie)
                                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                    
                                    VStack(spacing: 5, content: {
                                        TextInfoField(type: "Name:", text: productName)
                                        TextInfoField(type: "Supplier:", text: supplier)
                                        TextInfoField(type: "Stock:", text: String(currentStock))
                                    
                                    })
                                    .padding()
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                              
                                }
                                .padding(.horizontal)
                                Divider()
                                    .padding(.horizontal)
                                VStack(spacing: 5, content: {
                                    TextInfoField(type: "Product type:", text: productType)
                                    TextInfoField(type: "Packaging:", text: packaging )
                                    TextInfoField(type: "Quantity:", text: String(contentPerPackage))
                                    TextInfoField(type: "Price:", text: String(price))
                                    TextInfoField(type: "Weight:", text: "\(weight) g")
                                
                                })
                                .padding(.vertical)
                                .padding(.horizontal)
                                Divider()
                                    .padding(.horizontal)
                                VStack(spacing: 5, content: {
                                    TextInfoField(type: "GTIN:", text: String(gtin))
                                    TextInfoField(type: "Batch:", text: String(batch) )
                                    TextInfoField(type: "Best before:", text: bestBefore)
                                   
                                
                                })
                                .padding(.vertical)
                                .padding(.horizontal)
                                
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
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
    ProductView(productName: "test", supplier: "test", currentStock: 12, productType: "test", packaging: "test", contentPerPackage: 12, price: 20.0, weight: 21.0, gtin: 10, batch: 10, bestBefore: "12-09-99")
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
                .foregroundStyle(.darkgrey)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        }
    }
}

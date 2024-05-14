//
//  ShoppingCartSheetView.swift
//  Front End
//
//  Created by Siri Sandnes on 25/04/2024.
//

import SwiftUI

struct ShoppingCartSheetView: View {
    @Binding var itemSelected : Bool
    @Binding var wishedDelivery: Date
    @Binding var placeOrder : Bool //??
    @Binding var showSheet : Bool
    @Binding var productAmounts: [Int: Int]
    @Binding var user: User
    
    @ObservedObject var newOrderViewModel: NewOrderViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Image(systemName: "shippingbox")
                        .font(.system(size: 20))
                    Text("New order")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                
                Button("X") {
                    itemSelected = false
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.black).font(.system(size: 20))
                
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            .padding(.horizontal)
        }
        Spacer()
        VStack(spacing: 5){
            HStack{
                Text("Products selected:")
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                Spacer()
                Text(String(getAmountOfProducts(productAmountsList:productAmounts)))
                    .frame(maxWidth: 120)
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            .padding(.horizontal)
            DatePicker(selection: $wishedDelivery,
                       in: Date()...,
                       displayedComponents: .date,
                       label: {
                Text("Delivery date:")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            )
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding(.horizontal)
            HStack{
             
                Button(action: {
                    placeOrder = true
                    showSheet = false
                    
                }) {
                    HStack {
                        Text("Place order ")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(.greenProgressbar)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .frame(minWidth: 0, maxWidth: .infinity)
                
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            
        }
        .padding(.horizontal)
        .onAppear(){
            
        }
        
        Spacer()
    }
    
}

func getAmountOfProducts(productAmountsList: [Int:Int]) -> Int{
    print(productAmountsList)
    return productAmountsList.values.reduce(0, +)
}


#Preview {
    ShoppingCartSheetView(itemSelected: .constant(false), wishedDelivery: .constant(Date.now), placeOrder: .constant(false), showSheet: .constant(false), productAmounts: .constant([1:1]), user: .constant(User(email: "", firstName: "", lastName: "", store: Store(name: "", address: "", country: "", city: "", postalCode: 12, storeId: 12))), newOrderViewModel: NewOrderViewModel())
}

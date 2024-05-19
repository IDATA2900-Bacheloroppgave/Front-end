//
//  ConfirmOrderView.swift
//  Front End
//
//  Created by Ina Folland Hegg on 26/04/2024.
//

import SwiftUI

struct ConfirmOrderView: View {
    
    @Binding var wishedDelivery: Date
    @Binding var productAmounts: [Int: Int]
    @ObservedObject var newOrderViewModel: NewOrderViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    @Binding var placeOrder : Bool
    @Binding var showSheet : Bool
    @State private var showingAlert = false
    @State  private var noProductsInOrder = false
    
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color(.solwrBackground)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    VStack {
                        Text("Order Summary")
                            .foregroundStyle(.solwrMainTitle)
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                            .background(.solwrYellow)
                    }
                    VStack {
                        VStack {
                            Text("Products in order")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                                .padding()
                            if noProductsInOrder{
                                VStack{
                                    Spacer()
                                    Text("No products selected").foregroundStyle(.red)
                                    Spacer()
                                }
                            }else{
                                ScrollView {
                                    ForEach(newOrderViewModel.getSelectedProducts(productsAmounts: productAmounts), id: \.productId) { product in
                                        ShowOrderCardView(product: product, itemAvailable: product.inventory.availableStock > 0, availableQuantity: product.inventory.availableStock, productAmounts: $productAmounts)
                                        
                                        
                                    }
                                }
                               
                            }
                            VStack{
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
                            } .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                                .background(.solwrCardBackground)
                                .cornerRadius(5)
                                .shadow(radius: 1)
                                .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                                .padding(.horizontal)
                                
                            
                        
                            Button(action: {
                                performPlaceOrder()
                                
                            }) {
                                HStack {
                                    Text("Confirm Order")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(Color.black)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.black)
                                        .font(.system(size: 35))
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15) 
                                .background(.solwrYellow)
                                .cornerRadius(10)
                            }  .alert(isPresented:$showingAlert) {
                                Alert(title: Text("Order sucessfully placed"))
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
    
    func performPlaceOrder(){
        
        Task {
            if let token = authViewModel.getToken() {
                do {
                    productAmounts = newOrderViewModel.removeObsoleteProducts(orderlist: productAmounts)
                    if(!productAmounts.isEmpty){
                        try await newOrderViewModel.placeOrder(wishedDate: wishedDelivery, orderList: productAmounts, token: token)
                         print("placed order")
                         showingAlert = true
                    }else{
                        noProductsInOrder = true
                    }
                   
                } catch {
                    print("Failed to place order: \(error)")
                }
            } else {
                print("Authentication error: Token is missing.")
            }
        }
    }
    
}




#Preview {
    ConfirmOrderView(wishedDelivery: .constant(Date.now), productAmounts: .constant([1:1]), newOrderViewModel: NewOrderViewModel(), placeOrder: .constant(false), showSheet: .constant(false))
}

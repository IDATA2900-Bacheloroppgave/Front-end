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
    
   
    
var body: some View {
    NavigationStack{
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.96)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack {
                    Text("Order Summary")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        .background(.accent)
                }
                VStack {
                    VStack {
                        Text("Products in order")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .padding()
                        ScrollView {
                            ForEach(newOrderViewModel.products, id: \.productId) { product in
                                Text(product.name)
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
                                
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.black)
                                    .font(.system(size: 35))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15) // Adjust padding as needed
                            .background(.accent)
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
    ConfirmOrderView(wishedDelivery: .constant(Date.now), productAmounts: .constant([1:1]), newOrderViewModel: NewOrderViewModel())
}

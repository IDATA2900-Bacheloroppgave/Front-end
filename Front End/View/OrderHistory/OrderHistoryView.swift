//
//  OrderHistoryView.swift
//  Front End
//
//  Created by Siri Sandnes on 14/04/2024.
//

import SwiftUI


struct OrderHistoryView: View {
    @State private var selection = 0
    @EnvironmentObject var userStateViewModel : AuthViewModel
    @StateObject var ordersViewModel = OrdersViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.96)
                    .edgesIgnoringSafeArea(.all) // Ensure the color fills the entire screen
                VStack(alignment: .leading) {
                    HStack {
                        Text("Orders")
                            .font(.system(size: 22))
                            .frame(maxWidth: .infinity) // Stretch the text to fill the entire width
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                            .background(.accent)
                            
                    }
                    
                    HStack {
                        Picker("Options", selection: $selection) {
                            Text("Active").tag(0).foregroundStyle(Color.white)
                            Text("Past").tag(1)
                        }
                        .colorMultiply(.bluePicker)
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button(action: {}) {
                            Image(systemName: "line.horizontal.3")
                                .font(.system(size: 25))
                                .foregroundStyle(Color.black)
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack{
                        ScrollView{
                            if selection == 0{
                                let activeOrders = ordersViewModel.getActiveOrders()
                                ForEach(activeOrders, id: \.orderId) { order in
                                    NavigationLink{
                                        OrderInfoView(order: order)
                                    }label: {
                                        ActiveOrderCardView(
                                            orderNumber: String(order.orderId),
                                            productsInOrder:  ordersViewModel.getAmountOfProducts(order: order),
                                            status: order.orderStatus.lowercased(),
                                            estimatedDelivery: order.wishedDeliveryDate,
                                            progressValue: order.progressInPercent/100)
                                        .foregroundColor(.primary)
                                    }
                                }
                            }else{
                                let activeOrders = ordersViewModel.getPastOrders()
                                ForEach(activeOrders, id: \.orderId) { order in
                                    NavigationLink{
                                        OrderInfoView(order: order)
                                    }label: {
                                        PastOrderCardView(
                                            orderNumber: order.orderId,
                                            supplierName: 1,
                                            status: order.orderStatus,
                                            estimatedDelivery: order.wishedDeliveryDate,
                                            progressValue: order.progressInPercent/100)
                                        .foregroundColor(.primary)
                                    }
                                }
                            }

                        }
                    }
                }
            }
        }.tint(.black)
            .onAppear(){
                Task{
                    do{
                        try await ordersViewModel.fetchOrders(token: userStateViewModel.currentUser?.token ?? "")
                    }catch{
                        print("Could not fetch orders")
                    }
                }
                
            }
    }
}




#Preview {
    OrderHistoryView()
}


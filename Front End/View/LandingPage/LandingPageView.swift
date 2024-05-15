//
//  LandingPage.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//


import SwiftUI

struct LandingPageView: View {
    @EnvironmentObject var userStateViewModel : AuthViewModel
    @StateObject var ordersViewModel = OrdersViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isLoading = true
    
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(red: 0.96, green: 0.96, blue: 0.96)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 20) {
                    VStack {
                        Text("My deliveries")
                            .font(.system(size: 22))
                            .frame(maxWidth: .infinity) 
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                            .background(.accent)
                    }
                    
                    if isLoading {
                                   Spacer()
                                   
                                   ProgressView()
                                       .scaleEffect(1.5)
                                       .progressViewStyle(CircularProgressViewStyle(tint: .bluePicker))
                                       .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                   
                                   Spacer()
                                   
                                   yellowButton()
                                    
                               
                    }else{
                        ScrollView{
                            Title(title: "Next delivery")
                            if let nextOrder = ordersViewModel.getActiveOrders(o: ordersViewModel.orders).first {
                                NavigationLink{
                                    //HUSK Å HENDRE
                                    //HUSKE Å HENDRE
                                    OrderInfoView(order: nextOrder ) //Midlertidig for å ikke få feilmelding
                                }label: {
                                   DeliveryCardView(
                                    mainTitle: "Order (\(nextOrder.orderDate))", orderNumber: "#\(nextOrder.orderId)",
                                        progressValue: nextOrder.progressInPercent/100,
                                        currentLocation: "Current location: \(nextOrder.currentLocation ?? "unknown")",
                                        arrivalTime: "Requested delivery: \(nextOrder.wishedDeliveryDate)",
                                    supplierName: "Products: \(nextOrder.quantities.count)")
                                   .foregroundColor(.primary)
                                }
                            }else{
                                Text("No next order")
                            }
                            
                            
                            Title(title: "Upcoming deliveries")
                            
                            if ordersViewModel.getActiveOrders(o: ordersViewModel.orders).isEmpty{
                                Text("No orders to show")
                            }else{
                                ForEach(ordersViewModel.getActiveOrders(o: ordersViewModel.orders), id: \.orderId) { order in
                                    NavigationLink{
                                        OrderInfoView(order: order)
                                    }label: {
                                        ActiveOrderCardView(order: order)
                                        .foregroundColor(.primary)
                                    }
                                }
                            }
                            
                        }
                       yellowButton()
                        
                    }
                }
                
          
            }
        }
        .onAppear(){
            isLoading = true;
            Task {
                if let token = userStateViewModel.getToken() {
                    do {
                        try await ordersViewModel.fetchOrders(token: token)
                    } catch {
                        print("Failed to fetch orders: \(error.localizedDescription)")
                    }
                } else {
                    print("No token available, user might need to log in again.")
                }
                isLoading = false
            }
            
            
        }.tint(.black)
    }
}



#Preview {
    LandingPageView()
}




struct Title: View {
    var title: String
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.headline)
            .padding(.leading)
            .fontWeight(.medium)
            .padding(EdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 2))
    }
}

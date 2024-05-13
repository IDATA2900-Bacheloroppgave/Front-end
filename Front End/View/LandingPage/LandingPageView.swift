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
                            .frame(maxWidth: .infinity) // Stretch the text to fill the entire width
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                            .background(.accent)
                    }
                    
                    if isLoading{
                        VStack {
                            Spacer() // Pushes the progress view down in the ScrollView
                            ProgressView()
                                .scaleEffect(1.5)
                                .progressViewStyle(CircularProgressViewStyle(tint: .bluePicker))
                            Spacer() // Ensures the progress view stays centered
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }else{
                        ScrollView{
                            Title(title: "Next delivery")
                           
                            NavigationLink{
                                OrderInfoView(order: ordersViewModel.getActiveOrders().first!) //Midlertidig for å ikke få feilmelding
                            }label: {
                                DeliveryCardView(
                                    mainTitle: ordersViewModel.getActiveOrders().first!.orderDate,
                                    orderNumber: "#\(ordersViewModel.getActiveOrders().first!.orderId)",
                                    progressValue: ordersViewModel.getActiveOrders().first!.progressInPercent/100,
                                    currentLocation: "Current location: \(ordersViewModel.getActiveOrders().first!.currentLocation ?? "unknown")",
                                    arrivalTime: "Requested delivery: \(ordersViewModel.getActiveOrders().first!.wishedDeliveryDate)",
                                    supplierName: "Products: \(ordersViewModel.getAmountOfProducts(order: ordersViewModel.getActiveOrders().first!))")
                                .foregroundColor(.primary)
                            }
                            
                            Title(title: "Upcoming deliveries")
                            
                            ForEach(ordersViewModel.getActiveOrders(), id: \.orderId) { order in
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
                isLoading = false  // End loading
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

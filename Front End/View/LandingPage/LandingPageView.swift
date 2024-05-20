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
    @State private var showBarcode = false
    @State private var showSettings = false
    @State private var scannedCode: String?
    @State private var gotBarcode : Bool = false
    @State private var navigateToNewOrder = false
    
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(.solwrBackground)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 20) {
                    VStack {
                        Text("My deliveries")
                            .foregroundStyle(.solwrMainTitle)
                            .font(.system(size: 25))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 20, trailing: 0))
                            .background(.solwrMainTitleBackground)
                    }
                    
                    if isLoading {
                        Spacer()
                        
                        ProgressView()
                            .scaleEffect(1.5)
                            .progressViewStyle(CircularProgressViewStyle(tint: .solwrBlue))
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                        
                        Button(action: {
                            showBarcode = true
                        }) {
                            HStack {
                                Text("Scan to order")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color.black)
                                
                                Spacer()
                                
                                Image(systemName: "barcode.viewfinder")
                                    .foregroundColor(.black)
                                    .font(.system(size: 35))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(.solwrYellow)
                            .cornerRadius(10)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        
                        
                    }else{
                        ScrollView{
                            Title(title: "Next delivery")
                            if let nextOrder = ordersViewModel.getActiveOrders(o: ordersViewModel.orders).last{
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
                        Button(action: {
                            showBarcode = true
                        }) {
                            HStack {
                                Text("Scan to order")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color.black)
                                
                                Spacer()
                                
                                Image(systemName: "barcode.viewfinder")
                                    .foregroundColor(.black)
                                    .font(.system(size: 35))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(.solwrYellow)
                            .cornerRadius(10)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        
                    }
                }
                
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSettings = true
                    }) {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
        }
        
        .sheet(isPresented: $showBarcode){
            BarcodeScannerView(showBarcode: $showBarcode,scannedCode: $scannedCode, gotBarcode: $gotBarcode)
        }
        .sheet(isPresented: $showSettings) { // Present the settings view
                   SettingsView()
               }
        .onChange(of: scannedCode) { code, oldCode in
            if let barcode = code, !barcode.isEmpty {
                gotBarcode = true
                navigateToNewOrder = true
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

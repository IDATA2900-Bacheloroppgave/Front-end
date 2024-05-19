//
//  OrderHistoryView.swift
//  Front End
//
//  Created by Siri Sandnes on 14/04/2024.
//

import SwiftUI



struct OrderHistoryView: View {
    @State private var selection = 0
    @EnvironmentObject var userStateViewModel: AuthViewModel
    @StateObject var ordersViewModel = OrdersViewModel()
    @State private var isFilterVisible = false
    @State private var quickFilter = 0
    @State private var toDate = Date()
    @State private var fromDate = Date()
    @State private var dateNow = Date()
    @State private var isLoading = false


    var body: some View {
        NavigationStack {
            ZStack {
                Color(.solwrBackground)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Orders")
                            .foregroundStyle(.solwrMainTitle)
                            .font(.system(size: 22))
                            .frame(maxWidth: .infinity)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                            .background(.solwrMainTitleBackground)
                    }
                    
                    HStack {
                        Picker("Options", selection: $selection) {
                            Text("Active").tag(0).foregroundStyle(Color.white)
                            Text("Past").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button(action: {
                            isFilterVisible.toggle()
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.system(size: 25))
                                .foregroundStyle(Color.black)
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    if isLoading {
                        ProgressView()
                            .scaleEffect(1.5)
                            .progressViewStyle(CircularProgressViewStyle(tint: .solwrBlue))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView{
                            if selection == 0{
                                let activeOrders = ordersViewModel.getActiveOrders(o: filteredOrders)
                                ForEach(activeOrders, id: \.orderId) { order in
                                    NavigationLink{
                                        OrderInfoView(order: order)
                                    }label: {
                                        ActiveOrderCardView(order: order)
                                        .foregroundColor(.primary)
                                    }
                                }
                            }else{
                                let activeOrders = ordersViewModel.getPastOrders(o: filteredOrders)
                                ForEach(activeOrders, id: \.orderId) { order in
                                    NavigationLink{
                                        OrderInfoView(order: order)
                                    }label: {
                                        PastOrderCardView(order: order)
                                        .foregroundColor(.primary)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $isFilterVisible) {
                                   VStack {
                                       FilterOrderSheetView(isVisible: $isFilterVisible, quickFilter: $quickFilter, toDate: $toDate, fromDate: $fromDate, nowDate: $dateNow)
                                           .frame(maxWidth: .infinity) 
                                           .presentationDetents([.medium, .large])
                                   }
            }
        
        }
        .onAppear {
            loadOrders()
        }
    }
    
    func loadOrders() {
        isLoading = true
        Task {
            if let token = userStateViewModel.getToken() {
                try await ordersViewModel.fetchOrders(token: token)
            } else {
                print("No token available, user might need to log in again.")
            }
            isLoading = false
        }
    }
    
    var filteredOrders: [Order] {
          if quickFilter != 0 {
              // Apply quick filter
              if quickFilter == 1 {
                  // Filter for past week
                  let pastWeekDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
                  return ordersViewModel.orders.filter { order in
                      if let orderDate = order.orderDateAsDate {
                          return orderDate >= pastWeekDate
                      }
                      return false
                  }
              } else if quickFilter == 2 {
                  // Filter for past month
                  let pastMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
                  return ordersViewModel.orders.filter { order in
                      if let orderDate = order.orderDateAsDate {
                          return orderDate >= pastMonthDate
                      }
                      return false
                  }
              } else if quickFilter == 3 {
                  // Filter for past six months
                  let pastSixMonthsDate = Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date()
                  return ordersViewModel.orders.filter { order in
                      if let orderDate = order.orderDateAsDate {
                          return orderDate >= pastSixMonthsDate
                      }
                      return false
                  }
              }
              
          }
          
          if !Calendar.current.isDate(dateNow, equalTo: toDate, toGranularity: .day) || !Calendar.current.isDate(dateNow, equalTo: fromDate, toGranularity: .day){
              
              print("INSIDE")
              print(toDate)
              print(fromDate)
              print(dateNow)
              
              return ordersViewModel.orders.filter { order in
                  if let orderDate = order.orderDateAsDate {
                      return orderDate >= fromDate && orderDate <= toDate
                  }
                  return false
              }
          }
          
          return ordersViewModel.orders
      }
      
}

#Preview {
    OrderHistoryView()
}



#Preview {
    OrderHistoryView()
}


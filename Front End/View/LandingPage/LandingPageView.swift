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
                    ScrollView{
                        Text("Next delivery")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .padding(.leading)
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 0, leading: 2, bottom: 10, trailing: 2))
                        //The next arriving order
                        //Backedn here
                        NavigationLink{
                            OrderInfoView(order: Order(orderId: 1, orderDate: "", orderStatus: "", wishedDeliveryDate: "", progressInPercent: 0.8, customer: User(email: "", firstName: "", lastName: "", store: Store(name: "", address: "", country: "", city: "", postalCode: 1, storeId: 1)), quantities: [Quantity(productQuantity: 12, product: Product(productId: 1, name: "", description: "", supplier: "", bestBeforeDate: "", productType: "", price: 0.2, gtin: 1, batch: 1, packaging: Packaging(packageType: "", quantityPrPackage: 1, weightInGrams: 1, dimensionInCm3: 0.1)))])) //Midlertidig for å ikke få feilmelding
                        }label: {
                            DeliveryCardView(
                                mainTitle: "Frysevarer",
                                orderNumber: "#12345",
                                progressValue: 0.5,
                                currentLocation: "Current location: Skodje",
                                arrivalTime: "Requested delivery: Today 12 - 2 pm",
                                supplierName: "Gjørts AS")
                            .foregroundColor(.primary)
                        }
                        
                        Text("Upcoming deliveries")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .padding(.leading)
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 2))
                        
                        
                        
                        ForEach(ordersViewModel.getActiveOrders(orders: ordersViewModel.orders), id: \.orderId) { order in
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
            .onAppear(){
                Task{
                    do{
                        try await ordersViewModel.fetchOrders(token: userStateViewModel.currentUser?.token ?? "")
                    }catch{
                        print("Could not fetch orders")
                    }
                }
                
            }
        }.tint(.black)
    }
}
    
    
    #Preview {
        LandingPageView()
    }
    
    


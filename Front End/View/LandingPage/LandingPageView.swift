//
//  LandingPage.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//


import SwiftUI

struct LandingPageView: View {
    @EnvironmentObject var userStateViewModel : AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    
    
    var body: some View {
        NavigationStack {
            ZStack{
                // Background image
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // ScrollView showing delivery of the day, and next upcoming deliveries.
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Delivery of the day")
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding(.leading)
                            
                            //The next arriving order
                            NavigationLink{
                                OrderInfoView()
                            }label: {
                                DeliveryCardView(
                                    mainTitle: "Frysevarer",
                                    orderNumber: "#12345",
                                    progressValue: 0.5,
                                    currentLocation: "Current location: Skodje",
                                    arrivalTime: "Estimated delivery: Today 12 - 2 pm",
                                    supplierName: "Gjørts AS")
                                .foregroundColor(.primary)
                            }
                            Text("Upcoming deliveries")
                                .font(.headline)
                                .padding(.leading)
                            
                            //The subsequent upcoming deliveries
                            NavigationLink{
                                OrderInfoView()
                            }label: {
                                UpcomingDeliveryView(
                                    orderNumber: "#12345",
                                    supplierName: "Gjørts AS",
                                    status: "Your order is ready for transport.",
                                    estimatedDelivery: "Tomorrow between 10 - 11 am.",
                                    progressValue: 0.1)
                                .foregroundColor(.primary)
                            }
                            
                            NavigationLink{
                                OrderInfoView()
                            }label: {
                                UpcomingDeliveryView(
                                    orderNumber: "#12345",
                                    supplierName: "Gjørts AS",
                                    status: "Your order is registered.",
                                    estimatedDelivery: "Friday between 10 - 11 am.",
                                    progressValue: 0.05)
                                .foregroundColor(.primary)
                            }
                            
                            NavigationLink{
                                OrderInfoView()
                            }label: {
                                UpcomingDeliveryView(
                                    orderNumber: "#12345",
                                    supplierName: "Gjørts AS",
                                    status: "Your order is ready for transport.",
                                    estimatedDelivery: "Tomorrow between 10 - 11 am.",
                                    progressValue: 0.1)
                                .foregroundColor(.primary)
                            }
                        }
                    }
                    
                }
            }
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        if userStateViewModel.logout(){
                            dismiss()
                        }
                    }, label: {
                        Text("Log out")
                            .foregroundStyle(Color.black)
                    })
                }
            }
        }
    }
}


#Preview {
    LandingPageView()
}


struct ScanToOrderBtn: View {
    var body: some View {
        Button(action: {
            // Action for the button tap
        }) {
            HStack {
                Text("Scan to order")
                    .font(.system(size: 20, weight: .medium)) // Adjust font size and weight as needed
                    .foregroundColor(Color.black)
                
                Spacer() // This will push the text and the icon to opposite sides
                
                Image(systemName: "barcode.viewfinder")
                    .foregroundColor(.black)
                    .font(.system(size: 35)) // Adjust icon size as needed
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15) // Adjust padding as needed
            .background(Color.yellow) // Use the color that matches your design
            .cornerRadius(10) // Adjust corner radius to match your design
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
    }
}

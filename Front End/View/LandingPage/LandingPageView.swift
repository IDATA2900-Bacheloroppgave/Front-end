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
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .padding(.leading)
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 2))
                        
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
                    ScanToOrderBtn()
                }
            }
        }.tint(.black)
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

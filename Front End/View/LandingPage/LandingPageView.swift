//
//  LandingPage.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//


import SwiftUI

struct LandingPageView: View {
    @EnvironmentObject var loginViewModel : UserStateViewModel
    @Environment(\.dismiss) var dismiss
    
    let deliveryItems: [DeliveryItem] = [
            DeliveryItem(id: "1589284", title: "Ferskvarer", company: "Gjørts AS", productsCount: 30),
            DeliveryItem(id: "1579284", title: "Ferskvarer", company: "Gjørts AS", productsCount: 30),
            DeliveryItem(id: "1579294", title: "Ferskvarer", company: "Gjørts AS", productsCount: 30)
            // Add more items as needed
        ]
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color(red: 0.96, green: 0.96, blue: 0.96)
                VStack{
                    Text("Deliveries of the day").frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal)
                    ScrollView{
                        VStack(spacing: 8) {
                            ForEach(deliveryItems) { item in
                                DeliveryOfDayListElementView(deliveryItem: item)
                            }
                        }
                        .padding()
                    }
                    ScanToOrderBtn()
                    
                }
            }
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        if loginViewModel.logout(){
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

struct DeliveryItem: Identifiable {
    let id: String
    let title: String
    let company: String
    let productsCount: Int
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

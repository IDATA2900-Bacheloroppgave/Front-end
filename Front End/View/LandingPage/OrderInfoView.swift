//
//  OrderInfoView.swift
//  SolwrTest
//
//  Created by Ina Folland Hegg on 16/04/2024.
//

import SwiftUI

struct OrderInfoView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    HStack (alignment: .center){
                        
                        Text("Order")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                    }
                    
                    //The next arriving order
                    
                    DeliveryCardView(
                        mainTitle: "Frysevarer",
                        orderNumber: "#12345",
                        progressValue: 0.5,
                        currentLocation: "Current location: Skodje",
                        arrivalTime: "Estimated delivery: Today 12 - 2 pm",
                        supplierName: "Gjørts AS")
                    
                    HStack {
                        Text("Products in order")
                            .font(.headline)
                        .padding(.leading)
                        Spacer()
                    }
                    
                    //The subsequent upcoming deliveries
                    ProductInfoCard(
                        productName: "Speltrundstykker",
                        productIcon: "fork.knife.circle.fill",
                        supplierName: "Hatting",
                        batchNumber: 123,
                        bestBeforeDate: "17.05.24",
                        quantityInfo: "5 D-pak")
                    
                    ProductInfoCard(
                        productName: "Speltrundstykker",
                        productIcon: "fork.knife.circle.fill",
                        supplierName: "Hatting",
                        batchNumber: 123,
                        bestBeforeDate: "17.05.24",
                        quantityInfo: "5 D-pak")
                    
                    ProductInfoCard(
                        productName: "Speltrundstykker",
                        productIcon: "fork.knife.circle.fill",
                        supplierName: "Hatting",
                        batchNumber: 123,
                        bestBeforeDate: "17.05.24",
                        quantityInfo: "5 D-pak")
                    
                    ProductInfoCard(
                        productName: "Speltrundstykker",
                        productIcon: "fork.knife.circle.fill",
                        supplierName: "Hatting",
                        batchNumber: 123,
                        bestBeforeDate: "17.05.24",
                        quantityInfo: "5 D-pak")
                    
                    ProductInfoCard(
                        productName: "Speltrundstykker",
                        productIcon: "fork.knife.circle.fill",
                        supplierName: "Hatting",
                        batchNumber: 123,
                        bestBeforeDate: "17.05.24",
                        quantityInfo: "5 D-pak")
                    }
            }
        }
    }
}

#Preview {
    OrderInfoView()
}

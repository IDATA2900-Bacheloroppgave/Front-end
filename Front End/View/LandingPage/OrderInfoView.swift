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
            Color(red: 0.96, green: 0.96, blue: 0.96)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack {
                    Text("Order #122345")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity) // Stretch the text to fill the entire width
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        .background(.accent)
                }
                VStack {
                    DeliveryCardView(
                        mainTitle: "Frysevarer",
                        orderNumber: "#12345",
                        progressValue: 0.5,
                        currentLocation: "Current location: Skodje",
                        arrivalTime: "Estimated delivery: Today 12 - 2 pm",
                        supplierName: "Gjørts AS").padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    VStack {
                        Text("Products in order")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .padding()
                        ScrollView{
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
                    .padding(0)
                }
            }
        }
    }
}

#Preview {
    OrderInfoView()
}

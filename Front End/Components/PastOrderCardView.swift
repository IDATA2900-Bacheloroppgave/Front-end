//
//  PastOrderCardView.swift
//  Front End
//
//  Created by Siri Sandnes on 17/04/2024.
//

import SwiftUI

struct PastOrderCardView: View {
    
    let orderNumber: Int
    let supplierName: Int
    let status: String
    let estimatedDelivery: String
    let progressValue: Double
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "truck.box.fill")
                    
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.gray)
                
                Text(String("#\(orderNumber)"))
                    .fontWeight(.medium)
                    .font(.subheadline)
                Spacer()
                Text(String(supplierName))
                    .font(.footnote)
                    .foregroundStyle(Color(.greyText))
                
            }
            .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 0))
            
            ProgressView(value: progressValue)
                .tint(.greenProgressbar)
                .scaleEffect(x: 1, y: 2.5)
            
            HStack{
                VStack (alignment: .leading){
                    Text("Status: \(status.lowercased())")
                        .foregroundStyle(Color(.greyText))
                        .font(.footnote)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(EdgeInsets(top: 8, leading: 2, bottom: 5, trailing: 0 ))
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(5)
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
        .padding(.horizontal)
        .shadow(radius: 1)
    }
}

#Preview {
    PastOrderCardView(orderNumber: 1, supplierName: 1, status: "Skodje", estimatedDelivery: "Tomorrow before noon", progressValue: 1)
}

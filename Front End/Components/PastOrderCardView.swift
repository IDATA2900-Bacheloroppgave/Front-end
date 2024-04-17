//
//  PastOrderCardView.swift
//  Front End
//
//  Created by Siri Sandnes on 17/04/2024.
//

import SwiftUI

struct PastOrderCardView: View {
    
    let orderNumber: String
    let supplierName: String
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
                
                Text(orderNumber)
                    .fontWeight(.medium)
                    .font(.subheadline)
                Spacer()
                Text(supplierName)
                    .font(.footnote)
                    .foregroundColor(.gray)
                
            }
            .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 0))
            
            ProgressView(value: progressValue)
                .tint(.greenProgressbar)
                .scaleEffect(x: 1, y: 2.5)
            
            HStack{
                VStack (alignment: .leading){
                    Text("STATUS: \(status)")
                        .foregroundColor(.gray)
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
    PastOrderCardView(orderNumber: "#12345", supplierName: "Gjørts AS", status: "Skodje", estimatedDelivery: "Tomorrow before noon", progressValue: 1)
}

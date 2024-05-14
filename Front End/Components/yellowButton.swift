//
//  yellowButton.swift
//  Front End
//
//  Created by Siri Sandnes on 18/04/2024.
//

import SwiftUI

struct yellowButton: View {
    var body: some View {
        Button(action: {
     
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
            .background(.accent)
            .cornerRadius(10)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
    }
}


#Preview {
    yellowButton()
}

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


#Preview {
    yellowButton()
}

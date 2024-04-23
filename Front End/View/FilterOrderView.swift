//
//  FilterOrderView.swift
//  Front End
//
//  Created by Siri Sandnes on 23/04/2024.
//

import SwiftUI

struct FilterOrderView: View {
    @Binding var isVisible: Bool

        var body: some View {
            VStack {
                Text("Filter Options")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()

             

                // Close button
                Button("Close") {
                    isVisible = false
                }
                .foregroundColor(.black)
                .padding()
            }
         
            .background(Color.white)
            .cornerRadius(10)
            .padding()
        }
}

#Preview {
    FilterOrderView(isVisible: .constant(true))
}

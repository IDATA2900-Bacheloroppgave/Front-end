//
//  NewOrderView.swift
//  Front End
//
//  Created by Siri Sandnes on 14/04/2024.
//

import SwiftUI

struct NewOrderView: View {
    @StateObject var testViewModel = NewOrderViewModel()
    var body: some View {
        ZStack{
            Color(red: 0.96, green: 0.96, blue: 0.96)
            Text("Products")
            if let errorMessage = testViewModel.errorMessage{
                Text(errorMessage)
            }else{
            
            }
        }
    }
}

#Preview {
    NewOrderView()
}

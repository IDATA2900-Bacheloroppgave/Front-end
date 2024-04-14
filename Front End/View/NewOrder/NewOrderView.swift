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
        Text("Products")
        if let errorMessage = testViewModel.errorMessage{
            Text(errorMessage)
        }else{
        
        }
    }
}

#Preview {
    NewOrderView()
}

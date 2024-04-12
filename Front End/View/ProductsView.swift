//
//  TestView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI

struct ProductsView: View {
    @StateObject var testViewModel = ProductsViewModel()
    var body: some View {
    
        if let errorMessage = testViewModel.errorMessage{
            Text(errorMessage)
        }else{
        
        }
    }
}

#Preview {
    ProductsView()
}

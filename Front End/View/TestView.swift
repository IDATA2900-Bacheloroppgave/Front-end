//
//  TestView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI

struct TestView: View {
    @StateObject var testViewModel = TestViewModel()
    var body: some View {
        Button("hi"){
            testViewModel.fetchProductData()
        }
        if let errorMessage = testViewModel.errorMessage{
            Text(errorMessage)
        }else{
            
        }
    }
}

#Preview {
    TestView()
}

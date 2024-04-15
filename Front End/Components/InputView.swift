//
//  InputView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        if isSecureField{
            SecureField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .textInputAutocapitalization(.never)
                .listRowBackground(Color.init(red: 1.00, green: 0.83, blue: 0.00))
                .listRowSeparator(.hidden)
                .frame( width: 300, height: 50)
                
        }else{
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .textInputAutocapitalization(.never)
                .listRowBackground(Color.init(red: 1.00, green: 0.83, blue: 0.00))
                .listRowSeparator(.hidden)
                .frame( width: 300, height: 50)
                
                
        }
    }
}

#Preview {
    InputView(text: .constant(""), placeholder: "name@example.com")
}

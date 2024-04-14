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
                .frame(width: 300, height: 50)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .textInputAutocapitalization(.never)
        }else{
            TextField(placeholder, text: $text)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .textInputAutocapitalization(.never)
        }
    }
}

#Preview {
    InputView(text: .constant(""), placeholder: "name@example.com")
}

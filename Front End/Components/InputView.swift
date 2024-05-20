//
//  InputView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI

/**
 * 
 */

struct InputView: View {
    @Binding var text: String
    let placeholder: String
    var isSecureField = false
    var borderColor: Color = Color.black
    
    var body: some View {
    
        if isSecureField{
            SecureField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.black)
                .textInputAutocapitalization(.never)
                .listRowBackground(Color.init(.black))
                .listRowSeparator(.hidden)
                .frame( width: 300, height: 50)
                
        }else{
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke( borderColor, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.black)
                .textInputAutocapitalization(.never)
                .listRowBackground(Color.init(.black))
                .listRowSeparator(.hidden)
                .frame( width: 300, height: 50)
                
        }
    }
}


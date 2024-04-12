//
//  ContentView.swift
//  Front End
//
//  Created by Siri Sandnes on 11/04/2024.
//

import SwiftUI

struct NewUserView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var loginSuccessfull = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.init(red: 1.00, green: 0.83, blue: 0.00).ignoresSafeArea()
                VStack(spacing: 40){
                    Text("TraceGo").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 45))
                    VStack(spacing: 20){
                        InputView(text: $username, placeholder: "Username")
                        InputView(text: $password, placeholder: "Password", isSecureField: true)
                        InputView(text: $password, placeholder: "Repeat password", isSecureField: true)
                    }
                    Button("Create User"){
                        
                    }
                    .foregroundStyle(Color(.black))
                    .frame(width: 150, height: 50)
                    .background(Color.white)
                    .overlay(
                         RoundedRectangle(cornerRadius: 25)  // Set the corner radius here
                             .stroke(Color.black, lineWidth: 2)  // This adds the border
                     )
                     .clipShape(RoundedRectangle(cornerRadius: 25))
                  
                }
            }
        }
        .toolbar(.hidden)
    }
}

#Preview {
    NewUserView()
}

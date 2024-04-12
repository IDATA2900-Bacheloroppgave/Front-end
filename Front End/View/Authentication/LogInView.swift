//
//  LogInView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI


struct LogInView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var loginSuccessful = false  // Corrected the typo in variable name
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.00, green: 0.83, blue: 0.00).ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack(spacing: 40) {
                        Text("TraceGo")
                            .fontWeight(.bold)
                            .font(.system(size: 45))

                        VStack(spacing: 20) {
                            InputView(text: $username, placeholder: "Username")
                            InputView(text: $password, placeholder: "Password", isSecureField: true)
                        }
                        Button("Log in") {
                        
                        }
                        .foregroundColor(Color.black)
                        .frame(width: 150, height: 50)
                        .background(Color.white)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                    Spacer()
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(Color.black)
                        Button("Sign up") {
                         
                        }
                        .foregroundColor(Color.blue)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EmptyView()
            }
        }
    }
}


#Preview {
    LogInView()
}


//
//  LogInView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI


struct LogInView: View {
    @StateObject var loginViewModel = LoginViewModel()
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    
    
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
                            loginViewModel.login(email: "siris@gmail.com", password: "Testpassword11hehe")
                            print(loginViewModel.loggedIn)
                        }
                        .foregroundColor(Color.black)
                        .frame(width: 150, height: 50)
                        .background(Color.white)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        if loginViewModel.loggedIn{
                            Text("Loggefd in")
                        }
                    }
                    Spacer()
                    NavigationLink{
                        RegisterView()
                    }label: {
                        HStack (spacing: 3) {
                            Text("Don't have an account?")
                                .foregroundColor(Color.black)
                            Text("Sign up")
                            .foregroundColor(Color.blue)
                        }
                        .padding(.bottom, 20)
                    }
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

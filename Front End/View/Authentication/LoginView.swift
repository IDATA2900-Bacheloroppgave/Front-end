//
//  LogInView.swift
//  Front End
//
//  Created by Siri Sandnes on 12/04/2024.
//

import SwiftUI


struct LogInView: View {
    @EnvironmentObject var userStateViewModel : AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    
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

                        LazyVStack(spacing:20){
                            InputView(text: $email, placeholder: "Email")
                            InputView(text: $password, placeholder: "Password", isSecureField: true)
                        } 
                        .background(Color.init(red: 1.00, green: 0.83, blue: 0.00))
                        .scrollContentBackground(.hidden)
                        .scrollDisabled(true)

                        Button("Log in") {
                            Task{
                                do{
                                    try await userStateViewModel.login(email: email, password: password)
                                    print("user created")
                                }catch{
                                    print("Could not log in user")
                                }
                            }
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
